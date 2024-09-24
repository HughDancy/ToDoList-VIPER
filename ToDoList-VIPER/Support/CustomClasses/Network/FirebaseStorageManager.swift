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
import GoogleSignIn
import GoogleSignInSwift

final class FirebaseStorageManager {

    // MARK: - Property's
    private let storage = Storage.storage().reference()
    private let firestoreDataBase = Firestore.firestore()
    private var authManager = AuthKeychainManager()

    func chekOverdueTasks() {
        let uid = Auth.auth().currentUser?.uid ?? GIDSignIn.sharedInstance.currentUser?.userID
        guard let uuid = uid else { return }
        firestoreDataBase.collection("toDos").document(uuid).collection("tasks").getDocuments { result, error in
            if error == nil {
                guard let documents = result?.documents else { return }
                documents.forEach { document in
                    let serverDate = document["date"] as? Timestamp
                    let date = serverDate?.dateValue()
                    let statusFromServer = document["status"] as? String
                    if date ?? Date.today < Date.today && (statusFromServer ?? "In Progress") != "Done" && (statusFromServer ?? "In Progress") != "Fail" {
                        document.reference.updateData(["status": "Fail"])
                    }
                }
            } else {
                print("Some eeror happen in FirebaseStorageManager check overdue tasks")
            }
        }
    }

    func deleteTaskFromServer(_ id: String) {
        let uid = Auth.auth().currentUser?.uid ?? GIDSignIn.sharedInstance.currentUser?.userID
        guard let uuid = uid else { return }
        let collectionReference = firestoreDataBase.collection("toDos").document(uuid).collection("tasks")
        let query: Query = collectionReference.whereField("id", isEqualTo: id)
        query.getDocuments { snapshot, error in
            if let error = error {
                print("Some error went wehn try deleting task from server - \(error)")
            } else {
                snapshot!.documents.forEach { document in
                    self.firestoreDataBase.collection("toDos").document(uuid).collection("tasks").document(document.documentID).delete()
                }
            }
        }
    }
}

// MARK: - Download tasks
extension FirebaseStorageManager: LoginServerStorageProtocol {
    func loadTaskFromFirestore() async {
        let uid = Auth.auth().currentUser?.uid ?? GIDSignIn.sharedInstance.currentUser?.userID
        do {
            guard let uuid = uid else { return }
            let querySnapshot = try await firestoreDataBase.collection("toDos").document(uuid).collection("tasks").getDocuments()
            querySnapshot.documents.forEach { document in
                let task = document.data()
                let categoryFromServer = Category(rawValue: task["category"] as? String ?? "work")
                let category = TaskCategoryManager.manager.getCategoryData(from: categoryFromServer ?? Category.work)
                let statusFromServerString = task["status"] as? String
                let statusFromServer = ProgressStatus(rawValue: statusFromServerString ?? "In Progress")
                let timestamp = task["date"] as? Timestamp
                let date = timestamp?.dateValue()
                let overdueStatus = statusFromServer == .fail ? true : false
                let doneStatus = statusFromServer == .done ? true : false
                let id = task["id"] as? String
                let taskUid = UUID(uuidString: id ?? "")

                TaskStorageManager.instance.createNewToDo(title: task["title"] as? String ?? "Temp",
                                                          content: task["description"] as? String ?? "Description",
                                                          date: date ?? Date(),
                                                          isOverdue: overdueStatus,
                                                          color: category.1,
                                                          iconName: category.0,
                                                          doneStatus: doneStatus,
                                                          uid: taskUid ?? UUID.init())
            }
        } catch {
            print("Some error when download task from server on private context: \(error)")
        }
    }

    func chekOverdueToDos() {
        self.chekOverdueTasks()
    }

    func checkAvatar(avatar: UIImage, uid: String) {
        let avatarRef = storage.child(uid)
        if avatarRef.bucket.isEmpty {
            self.saveImage(image: avatar, name: uid)
        }
    }
}

// MARK: - Interface for MainScreen Module
extension FirebaseStorageManager: MainScreenServerStorageProtocol {
    func newLoadAvatar(compelition: @escaping (_ imageUrl: URL?) -> Void) {
        guard let userId = authManager.id else { return  }
        let avatarRef = storage.child(userId)

        avatarRef.downloadURL { url, error in
            if error != nil {
                print("When download avatar url something went wrong")
            } else {
                UserDefaults.standard.set(url, forKey: UserDefaults.Keys.userAvatar)
                compelition(url)
            }
        }
    }
}

// MARK: - Interface for AddNewToDo Module
extension FirebaseStorageManager: AddNewToDoServerStorageProtocol {
    func uploadTaskToServer(with task: ToDoTask) {
        let uid = Auth.auth().currentUser?.uid ?? GIDSignIn.sharedInstance.currentUser?.userID
        guard let uuid = uid else { return }
        do {
            try firestoreDataBase.collection("toDos").document(uuid).collection("tasks").addDocument(from: task)
        } catch {
            print(error)
        }
    }
}

// MARK: - Interface for ToDos Module
extension FirebaseStorageManager: ToDosServerStorageProtocol {
    func makeTaskDone(_ id: UUID) {
        let uid = Auth.auth().currentUser?.uid ?? GIDSignIn.sharedInstance.currentUser?.userID
        guard let uuid = uid else { return }
        let taskId = id.uuidString
        firestoreDataBase.collection("toDos").document(uuid).collection("tasks").whereField("id", isEqualTo: taskId).getDocuments { result, error in
            if error == nil {
                guard let documents = result?.documents.first else { return }
                documents.reference.updateData(["status" : ProgressStatus.done.value])
            }
        }
    }

    func deleteToDoFromServer(_ id: String) {
        self.deleteTaskFromServer(id)
    }
}

// MARK: - Interface for ToDos Detail Module
extension FirebaseStorageManager: ToDoSDetailServerStorageProtocol {
    func uploadChanges(task: ToDoTask) {
        let uid = Auth.auth().currentUser?.uid ?? GIDSignIn.sharedInstance.currentUser?.userID
        guard let uuid = uid else { return }

        firestoreDataBase.collection("toDos").document(uuid).collection("tasks").whereField("id", isEqualTo: task.id.uuidString).getDocuments { result, error in
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
            } else {
                print("Went some error when try save editing task to server!")
            }
        }
    }

    func deleteTask(_ id: String) {
        self.deleteTaskFromServer(id)
    }
}

// MARK: - User Avatar Saving In Server
extension FirebaseStorageManager: UserAvatarSaveInServerProtocol {
    // MARK: - Upload and load avatar to/from server
    func saveImage(image: UIImage, name: String) {
        guard let data = image.jpegData(compressionQuality: 8.0) else { return }
        let avatarRef = storage.child(name)
        avatarRef.putData(data, metadata: StorageMetadata(dictionary: ["contentType" : "image/jpeg"])) { (metaData, _) in
            guard metaData != nil else {
                print("Meta data not found or somehow another error")
                return
            }
            NotificationCenter.default.post(name: NotificationNames.updateUserData.name, object: nil)
        }
    }
}
