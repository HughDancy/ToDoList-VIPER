//
//  ToDoObject+CoreDataProperties.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 21.11.2023.
//
//

import Foundation
import CoreData


extension ToDoObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoObject> {
        return NSFetchRequest<ToDoObject>(entityName: "ToDoObject")
    }

    @NSManaged public var title: String?
    @NSManaged public var descriptionTitle: String?
    @NSManaged public var date: Date?
    @NSManaged public var dateTitle: String?
    @NSManaged public var doneStatus: Bool

}

extension ToDoObject : Identifiable {

}
