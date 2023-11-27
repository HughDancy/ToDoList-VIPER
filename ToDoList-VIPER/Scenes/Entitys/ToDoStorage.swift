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
    func createNewToDo(title: String, content: String, date: Date, done: Bool) {
        let newToDo = ToDoObject(context: viewContext)
        newToDo.title = title
        newToDo.descriptionTitle = content
        newToDo.date = date
        newToDo.dateTitle = DateFormatter.createMediumDate(from: date)
        
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
    private func editToDoObject(item: ToDoObject, newTitle: String, newDescription: String, newDate: Date) {
        item.title = newTitle
        item.descriptionTitle = newDescription
        item.date = newDate
        item.dateTitle = DateFormatter.createMediumDate(from: newDate)
        
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
    func fetchUsers() -> [ToDoObject] {
        let fetchRequest: NSFetchRequest<ToDoObject> = ToDoObject.fetchRequest()
        let objects = try! viewContext.fetch(fetchRequest)
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
