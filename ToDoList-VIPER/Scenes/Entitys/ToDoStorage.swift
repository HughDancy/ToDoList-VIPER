//
//  ToDoStorage.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 24.11.2023.
//

import Foundation
import CoreData

final class ToDoStorage {
    static let instance = ToDoStorage()
    
    //MARK: - Context
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ToDoList_VIPER")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private lazy var viewContext: NSManagedObjectContext = persistentContainer.viewContext
    
    //MARK: - CoreData create new ToDoObject
    func createNewToDo(title: String, content: String, date: Date, done: Bool, color: String) {
        let newToDo = ToDoObject(context: viewContext)
        newToDo.title = title
        newToDo.descriptionTitle = content
        newToDo.date = date
        newToDo.dateTitle = DateFormatter.getStringFromDate(from: date)
        newToDo.color = color
        do {
            try viewContext.save()
        }
        catch {
            
        }
    }
    
    //MARK: - CoreData delete ToDoObject
    func deleteToDoObject(item: ToDoObject) {
        viewContext.delete(item)
        
        do {
            try viewContext.save()
        }
        catch {
            
        }
    }
    
    //MARK: - CoreData edit ToDoObject
    func editToDoObject(item: ToDoObject, newTitle: String, newDescription: String, newDate: Date, color: String) {
        item.title = newTitle
        item.descriptionTitle = newDescription
        item.date = newDate
        item.dateTitle = DateFormatter.getStringFromDate(from: newDate)
        item.color = color
        
        do {
            try viewContext.save()
        }
        catch {
            
        }
    }
    
    //MARK: - CoreData Done ToDoObject
    func doneToDo(item: ToDoObject) {
        item.doneStatus = true
        do {
            try viewContext.save()
        }
        catch {
            
        }
    }
    
    //MARK: - CoreData fetch
    func fetchToDos() -> [ToDoObject] {
        let fetchRequest: NSFetchRequest<ToDoObject> = ToDoObject.fetchRequest()
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
        print(objects)
        return objects
    }
    
    func fetchDoneToDos(with date: Date) -> [ToDoObject] {
        let fetchRequest: NSFetchRequest<ToDoObject> = ToDoObject.fetchRequest()
//        let donePredicate = NSPredicate(format: "doneStatus == YES")
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
        let donePredicate = NSPredicate(format: "doneStatus == nil")
        let datePredicate = NSPredicate(format: "%K == %@", #keyPath(ToDoObject.dateTitle), DateFormatter.getStringFromDate(from: date))
        let secondDatePredicate = NSPredicate(format: "%K <= %@", #keyPath(ToDoObject.date), Date.yesterday as NSDate)
        let subPredicates = [donePredicate, secondDatePredicate, datePredicate]
        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: subPredicates)
        fetchRequest.fetchBatchSize = 7
        let objects = try! viewContext.fetch(fetchRequest)
        print(objects)
        return objects
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
}
