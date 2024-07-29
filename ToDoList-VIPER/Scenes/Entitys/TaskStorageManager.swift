//
//  ToDoStorage.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 24.11.2023.
//

import Foundation
import CoreData
import UIKit.UIColor

final class TaskStorageManager {
    static let instance = TaskStorageManager()
    private let overdueRefresher = OverdueStatusRefresher()
    
    //MARK: - PersistentContainer and Context
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ToDoList_VIPER")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private lazy var privateContext: NSManagedObjectContext =  {
        let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateContext.persistentStoreCoordinator = self.persistentContainer.persistentStoreCoordinator
        return privateContext
    }()
    
    private lazy var viewContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.parent = privateContext
        context.automaticallyMergesChangesFromParent = true
        context.shouldDeleteInaccessibleFaults = true
        return context
    }()
    
    //MARK: - CoreData create new ToDoObject
    func createNewToDo(title: String, content: String, date: Date, isOverdue: Bool, color: UIColor, iconName: String, doneStatus: Bool, uid: UUID) {
        let newToDo = ToDoObject(context: viewContext)
        newToDo.title = title
        newToDo.descriptionTitle = content
        newToDo.date = date
        newToDo.dateTitle = DateFormatter.getStringFromDate(from: date)
        newToDo.color = color
        newToDo.isOverdue = isOverdue
        newToDo.doneStatus = doneStatus
        newToDo.iconName = iconName
        newToDo.id = uid
        self.saveChanges()
    }
    
    //MARK: - CoreData delete ToDoObject
    func deleteAllEntities() {
        let entities = persistentContainer.managedObjectModel.entities
        for entity in entities {
            delete(entityName: entity.name!)
        }
    }
    
    private func delete(entityName: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try persistentContainer.viewContext.execute(deleteRequest)
            saveChanges()
        } catch let error as NSError {
            debugPrint(error)
        }
    }
    
    func deleteTaskWithId(_ uid: UUID) {
        let fetchRequest: NSFetchRequest<ToDoObject> = ToDoObject.fetchRequest()
        let idPredicate = NSPredicate(format: "%K == %@", "id", uid as CVarArg)
        fetchRequest.predicate = idPredicate
        let objects = try! viewContext.fetch(fetchRequest)
        let object = objects.first
        viewContext.delete(object ?? ToDoObject())
        self.saveChanges()
        
    }
    
    //MARK: - CoreData edit ToDoObject
    func editToDoObject(item: ToDoObject, newTitle: String, newDescription: String, newDate: Date, color: UIColor, iconName: String) {
        if item.title != newTitle {
            item.title = newTitle
        }
        
        if item.descriptionTitle != newDescription {
            item.descriptionTitle = newDescription
        }
        
        if item.date != newDate {
            item.date = newDate
            item.dateTitle = DateFormatter.getStringFromDate(from: newDate)
        }
        
        if item.color != color {
            item.color = color
            item.iconName = iconName
        }
        
        self.saveChanges()
    }
    
    //MARK: - CoreData Done ToDoObject
    func doneToDo(_ id: UUID) {
        let fetchRequest: NSFetchRequest<ToDoObject> = ToDoObject.fetchRequest()
        let idPredicate = NSPredicate(format: "%K == %@", "id", id as CVarArg)
        fetchRequest.predicate = idPredicate
        let objects = try! viewContext.fetch(fetchRequest)
        let object = objects.first
        object?.doneStatus = true
        self.saveChanges()
    }
    
    //MARK: - CoreData fetch ToDosObject methods
    func fetchAllToDosCount() -> Int {
        let fetchRequest = NSFetchRequest<NSNumber>(entityName: "ToDoObject")
        fetchRequest.resultType = .countResultType
        let objects = try! viewContext.fetch(fetchRequest)
        let objectsCount = objects.first?.intValue
        return objectsCount ?? 0
    }
    
    func fetchDateRangeToDos(date: [Date]) -> [ToDoObject] {
        let fetchRequest: NSFetchRequest<ToDoObject> = ToDoObject.fetchRequest()
        let fromDate = date.first ?? Date.today
        let toDate = date.last ?? Date.tomorrow
        let calendar = NSCalendar.current
        let startDate = calendar.startOfDay(for: fromDate)
        let endDate = calendar.startOfDay(for: toDate)
        let predicateDate = NSPredicate(format: "date >= %@ && date <= %@", startDate as NSDate, endDate as NSDate)
        fetchRequest.predicate = predicateDate
        let objects = try! viewContext.fetch(fetchRequest)
        return objects
    }
    
    func fetchConcreteToDos(with date: Date) -> [ToDoObject] {
        let fetchRequest: NSFetchRequest<ToDoObject> = ToDoObject.fetchRequest()
        let predicate = NSPredicate(format: "%K == %@",
                                    #keyPath(ToDoObject.dateTitle), DateFormatter.getStringFromDate(from: date))
        fetchRequest.predicate = predicate
        fetchRequest.fetchBatchSize = 7
        let objects = try! viewContext.fetch(fetchRequest)
        return objects
    }
    
    func fetchDoneToDos(with date: Date) -> [ToDoObject] {
        let fetchRequest: NSFetchRequest<ToDoObject> = ToDoObject.fetchRequest()
        let donePredicate = NSPredicate(format: "%K == %@", "doneStatus", NSNumber(value: true))
        let datePredicate = NSPredicate(format: "%K == %@", #keyPath(ToDoObject.dateTitle), DateFormatter.getStringFromDate(from: date))
        let subPredicates = [donePredicate, datePredicate]
        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: subPredicates)
        fetchRequest.fetchBatchSize = 7
        let objects = try! viewContext.fetch(fetchRequest)
        return objects
    }
    
    func fetchOverdueToDos(with date: Date) -> [ToDoObject] {
        let fetchRequest: NSFetchRequest<ToDoObject> = ToDoObject.fetchRequest()
        let subPredicates = self.createPredicates(with: .overdue, date: date)
        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: subPredicates)
        fetchRequest.fetchBatchSize = 7
        let objects = try! viewContext.fetch(fetchRequest)
        return objects
    }
    //MARK: - TO-DO: Check this method and rewrite
    //MARK: - Fetch count ToDosObjects Method
    func fetchToDosCount(with status: ToDoListStatus)  -> Int {
        let fetchRequest = NSFetchRequest<NSNumber>(entityName: "ToDoObject")
        fetchRequest.resultType = .countResultType
        
        switch status {
        case .today:
            let predicate = self.createPredicates(with: .today, date: Date.today)
            fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicate)
            let objects = try! viewContext.fetch(fetchRequest)
            let objectsCount = objects.first?.intValue
            self.checkOverdueTasksInServer()
            return objectsCount ?? 0
        case .tommorow:
            let predicate = self.createPredicates(with: .tommorow, date: Date.tomorrow)
            fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicate)
            let objects = try! viewContext.fetch(fetchRequest)
            let objectsCount = objects.first?.intValue
            return objectsCount ?? 0
        case .overdue:
            let predicate = self.createPredicates(with: .overdue, date: .yesterday)
            fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate[0], predicate[1]])
            let objects = try! viewContext.fetch(fetchRequest)
            let objectsCount = objects.first?.intValue
            return objectsCount ?? 0
        case .done:
            let predicate = self.createPredicates(with: .done, date: .today)
            fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicate)
            let objects = try! viewContext.fetch(fetchRequest)
            let objectsCount = objects.first?.intValue
            return objectsCount ?? 0
        }
    }
    
    //MARK: - Create predicates for cathegories
    private func createPredicates(with status: ToDoListStatus, date: Date) -> [NSPredicate] {
        switch status {
        case .today, .tommorow:
            let predicate = NSPredicate(format: "%K == %@",
                                        #keyPath(ToDoObject.dateTitle), DateFormatter.getStringFromDate(from: date))
            let donePredicate = NSPredicate(format: "%K == %@", "doneStatus", NSNumber(value: false))
            return [predicate, donePredicate]
        case .done:
            let donePredicate = NSPredicate(format: "%K == %@", "doneStatus", NSNumber(value: true))
            return [donePredicate]
        case .overdue:
            let donePredicate = NSPredicate(format: "doneStatus == NO")
            let overduePredicate = NSPredicate(format: "isOverdue == TRUE")
            let datePredicate = NSPredicate(format: "dateTitle == %@", DateFormatter.getStringFromDate(from: date))
            return [donePredicate, overduePredicate, datePredicate]
        }
    }
    
    func checkOverdueToDos() {
        let fetchRequest: NSFetchRequest<ToDoObject> = ToDoObject.fetchRequest()
        let calendar = NSCalendar.current
        let todayDate = calendar.startOfDay(for: Date())
        let predicateDate = NSPredicate(format: "date < %@", todayDate as NSDate)
        let donePredicate = NSPredicate(format: "doneStatus != YES")
        let overduePredicate = NSPredicate(format: "isOverdue != YES")
        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicateDate, donePredicate, overduePredicate])
        let objects = try! viewContext.fetch(fetchRequest)
        objects.forEach { $0.isOverdue = true }
        self.saveChanges()
    }
    
    //MARK: - CoreData Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func saveChanges() {
        viewContext.performAndWait {
            do {
                if self.viewContext.hasChanges {
                    try self.viewContext.save()
                }
            } catch {
                print("Unable to Save Changes of Main Managed Object Context")
                print("\(error), \(error.localizedDescription)")
            }
        }
        
        privateContext.perform {
            do {
                if self.privateContext.hasChanges {
                    try self.privateContext.save()
                }
            } catch {
                print("Unable to Save Changes of Private Managed Object Context")
                print("\(error), \(error.localizedDescription)")
            }
        }
    }
}

private extension TaskStorageManager {
    func checkOverdueTasksInServer() {
        overdueRefresher.loadDataIfNeeded { bool in
            if bool {
                let firebaseStorage = FirebaseStorageManager()
                Task {
                    print("CheckOverdueTasksIn Server is work")
                    firebaseStorage.chekOverdueTasks()
                }
            }
        }
    }
}

