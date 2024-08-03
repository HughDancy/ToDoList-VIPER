//
//  TaskStorageProtocols.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 03.08.2024.
//

import UIKit

protocol ToDosDetailLocalStorageProtocol: AnyObject {
    func editToDoObject(item: ToDoObject, newTitle: String, newDescription: String, newDate: Date, color: UIColor, iconName: String)
    func deleteTask(_ uid: UUID)
}
