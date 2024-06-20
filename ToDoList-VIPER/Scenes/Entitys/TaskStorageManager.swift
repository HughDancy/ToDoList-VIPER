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
    
    //MARK: - Context
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ToDoList_VIPER")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        container.viewContext.shouldDeleteInaccessibleFaults = true
        container.viewContext.automaticallyMergesChangesFromParent = false
        return container
    }()
    
    private lazy var viewContext: NSManagedObjectContext = persistentContainer.viewContext
    
    //MARK: - CoreData create new ToDoObject
    func createNewToDo(title: String, content: String, date: Date, isOverdue: Bool, color: UIColor, iconName: String) {
        let newToDo = ToDoObject(context: viewContext)
        newToDo.title = title
        newToDo.descriptionTitle = content
        newToDo.date = date
        newToDo.dateTitle = DateFormatter.getStringFromDate(from: date)
        newToDo.color = color
        newToDo.isOverdue = isOverdue
        newToDo.doneStatus = false
        newToDo.iconName = iconName
        do {
            try viewContext.save()
        }
        catch {
            print(error)
        }
    }
 
    //MARK: - CoreData delete ToDoObject
    func deleteToDoObject(item: ToDoObject) {
        viewContext.delete(item)
        
        do {
            try viewContext.save()
        }
        catch {
            print(error)
        }
    }
    
    //MARK: - CoreData edit ToDoObject
    func editToDoObject(item: ToDoObject, newTitle: String, newDescription: String, newDate: Date, color: UIColor, iconName: String) {
        item.title = newTitle
        item.descriptionTitle = newDescription
        item.date = newDate
        item.dateTitle = DateFormatter.getStringFromDate(from: newDate)
        item.color = color
        item.iconName = iconName
        
        do {
            try viewContext.save()
        }
        catch {
            print(error)
        }
    }
    
    //MARK: - CoreData Done ToDoObject
    func doneToDo(item: ToDoObject) {
        item.doneStatus = true
        do {
            try viewContext.save()
        }
        catch {
            print(error)
        }
    }
    
    //MARK: - CoreData fetch ToDosObject methods
    func fetchAllToDos() -> [ToDoObject] {
        let fetchRequest: NSFetchRequest<ToDoObject> = ToDoObject.fetchRequest()
        let objects = try! viewContext.fetch(fetchRequest)
        return objects
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
        print("Private context - \(objects)")
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
        let subPredicates = self.createPredicates(with: .overdue, date: date)
        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: subPredicates)
        fetchRequest.fetchBatchSize = 7
        let objects = try! viewContext.fetch(fetchRequest)
        return objects
    }
    //MARK: - TO-DO: Check this method and rewrite 
    //MARK: - Fetch count ToDosObjects Method
    func fetchToDosCount(with status: ToDoListStatus) -> Int {
        let fetchRequest = NSFetchRequest<NSNumber>(entityName: "ToDoObject")
        fetchRequest.resultType = .countResultType
        
        switch status {
        case .today:
            let predicate = self.createPredicates(with: .today, date: Date.today)
            fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicate)
            let objects = try! viewContext.fetch(fetchRequest)
            let objectsCount = objects.first?.intValue
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
//            let datePredicate = NSPredicate(format: "%K == %@", #keyPath(ToDoObject.dateTitle), DateFormatter.getStringFromDate(from: date))
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
        self.saveContext()
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

