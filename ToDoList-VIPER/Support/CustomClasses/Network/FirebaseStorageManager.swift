//
//  FirebaseStorageManager.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 11.06.2024.
//

import Foundation
import UIKit.UIImage
import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore
import Kingfisher

final class FirebaseStorageManager {
    //    static let shared = FirebaseStorageManager()
    
    //MARK: - Property's
    private let storage = Storage.storage().reference()
    private let db = Firestore.firestore()
    private var authManager = AuthKeychainManager()
    
    //MARK: - Upload and load avatar to/from server
    func saveImage(image: UIImage, name: String) {
        guard let data = image.jpegData(compressionQuality: 8.0) else { return }
        let avatarRef = storage.child(name)
        avatarRef.putData(data, metadata: StorageMetadata(dictionary: ["contentType" : "image/jpeg"])) { (metaData, error) in
            guard metaData != nil else {
                print("Meta data not found or somehow another error")
                return
            }
            NotificationCenter.default.post(name: NotificationNames.updateUserData.name, object: nil)
        }
    }
    
    func newLoadAvatar(compelition: @escaping (_ imageUrl : URL?) -> Void) {
        guard let userId = authManager.id else  { return  }
        let avatarRef = storage.child(userId)
        
        avatarRef.downloadURL { url, error in
            if error != nil {
                print("When download avatar url something went wrong")
            } else {
                UserDefaults.standard.set(url, forKey: "UserAvatar")
                compelition(url)
            }
        }
    }
}
//MARK: - Upload task to server
extension FirebaseStorageManager {
    func uploadTaskToServer(with task: ToDoTask) {
        let uid = Auth.auth().currentUser?.uid ?? UUID().uuidString
        do {
            try db.collection("toDos").document(uid).collection("tasks").addDocument(from: task)
        }
        catch {
            print(error)
        }
    }
}

//MARK: - Download tasks
extension FirebaseStorageManager {
    func loadTaskFromFirestore() async  {
        let uid = Auth.auth().currentUser?.uid ?? UUID().uuidString
        do {
            let querySnapshot = try await db.collection("toDos").document(uid).collection("tasks").getDocuments()
            querySnapshot.documents.forEach { document in
                let task = document.data()
                let categoryFromServer = Category(rawValue: task["category"] as? String ?? "work")
                let category = TaskCategoryManager.manager.getCategoryData(from: categoryFromServer ?? Category.work)
                let statusFromServerString = task["status"] as? String
                let statusFromServer = ProgressStatus(rawValue: statusFromServerString ?? "In Progress")
                let timestamp = task["date"] as! Timestamp
                let date = timestamp.dateValue()
                let overdueStatus = statusFromServer == .fail ? true : false
                print("For task name - \(task["title"] ?? ""), his date is - \(date) overdue status is - \(overdueStatus)")
                let doneStatus = statusFromServer == .done ? true : false
                
                TaskStorageManager.instance.createNewToDo(title: task["title"] as? String ?? "Temp",
                                                          content: task["description"] as? String ?? "Description",
                                                          date: date,
                                                          isOverdue: overdueStatus,
                                                          color: category.1,
                                                          iconName: category.0,
                                                          doneStatus: doneStatus)
                
                
            }
        } catch {
            print("Some error when download task from server on private context: \(error)")
        }
    }
}

//MARK: - Save editing task
extension FirebaseStorageManager {
    func uploadChanges(task: ToDoTask) {
        let uid = Auth.auth().currentUser?.uid ?? UUID().uuidString
        
        db.collection("toDos").document(uid).collection("tasks").whereField("title", isEqualTo: task.title).getDocuments { result, error in
            if error == nil {
                guard let documents = result?.documents.first else { return }
                let serverDate = documents["date"] as? Timestamp
                let date = serverDate?.dateValue()
                
                if documents["title"] as? String != task.title {
                    documents.reference.updateData(["title" : task.title])
                }
                
                if documents["description"] as? String != task.descriptionTitle {
                    documents.reference.updateData(["description" : task.descriptionTitle])
                }
                
                if date != task.date {
                    documents.reference.updateData(["date" : task.date])
                }
                
                if documents["status"] as? String != task.status.value {
                    documents.reference.updateData(["status" : task.status.value])
                }
                
                if documents["category"] as? String != task.category.value {
                    documents.reference.updateData(["category" : task.category.value])
                }
            }
        }
    }
}


//MARK: - Delete function
extension FirebaseStorageManager {
    func deleteTaskFromServer(_ task: ToDoTask) {
        let uid = Auth.auth().currentUser?.uid ?? UUID().uuidString
        
        let collectionReference = db.collection("toDos").document(uid).collection("tasks")
        let query : Query = collectionReference.whereField("title", isEqualTo: task.title)
        query.getDocuments(completion: { (snapshot, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                for document in snapshot!.documents {
                    self.db.collection("toDos").document(uid).collection("tasks").document("\(document.documentID)").delete()
                }
            }})
    }
}

extension FirebaseStorageManager {
    func makeToDoDone(_ task: ToDoTask) {
        let uid = Auth.auth().currentUser?.uid ?? UUID().uuidString
        db.collection("toDos").document(uid).collection("tasks").whereField("title", isEqualTo: task.title).getDocuments { result, error in
            if error == nil {
                guard let documents = result?.documents.first else { return }
                documents.reference.updateData(["status" : ProgressStatus.done.value])
            }
        }
    }
}

extension FirebaseStorageManager  {
    func chekOverdueTasks()  {
        let uid = Auth.auth().currentUser?.uid ?? UUID().uuidString
        db.collection("toDos").document(uid).collection("tasks").getDocuments { result, error in
            if error == nil {
                guard let documents = result?.documents else { return }
                documents.forEach { document in
                    let serverDate = document["date"] as? Timestamp
                    let date = serverDate?.dateValue()
                    let statusFromServer = document["status"] as? String
                    if date ?? Date.today < Date.today && (statusFromServer ?? "In Progress") != "Done" && (statusFromServer ?? "In Progress") != "Fail" {
                        document.reference.updateData(["status" : "Fail"])
                    }
                }
            } else {
                print("Some eeror happen in FirebaseStorageManager check overdue tasks")
            }
        }
    }
}

