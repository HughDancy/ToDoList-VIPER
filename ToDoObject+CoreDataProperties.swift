//
//  ToDoObject+CoreDataProperties.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 21.11.2023.
//
//

import Foundation
import CoreData
import UIKit.UIColor

extension ToDoObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoObject> {
        return NSFetchRequest<ToDoObject>(entityName: "ToDoObject")
    }

    @NSManaged public var title: String?
    @NSManaged public var descriptionTitle: String?
    @NSManaged public var date: Date?
    @NSManaged public var dateTitle: String?
    @NSManaged public var doneStatus: Bool
    @NSManaged public var isOverdue: Bool
    @NSManaged public var color: UIColor?
    @NSManaged public var iconName: String?
    @NSManaged public var id: UUID?

}

extension ToDoObject: Identifiable {

}
