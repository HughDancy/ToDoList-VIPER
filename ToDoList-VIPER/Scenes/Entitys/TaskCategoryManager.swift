//
//  TaskCategoryManager.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 02.05.2024.
//

import UIKit.UIColor

struct TaskCategory {
    var title: String
    var color: UIColor
    var iconName: String
}

/// ToDo in later updates: This class can be used to store, add and remove custom categories
final class TaskCategoryManager {
    static let manager = TaskCategoryManager()
    
    private var categoryStack: [TaskCategory] = [
        TaskCategory(title: "Работа", color: .systemOrange, iconName: "briefcase"),
        TaskCategory(title: "Личное", color: .taskGreen, iconName: "person"),
        TaskCategory(title: "Иное", color: .systemPurple, iconName: "books.vertical.circle")
    ]
    
    func fetchCategories() -> [TaskCategory] {
        return categoryStack
    }
}

extension TaskCategoryManager {
    func getCategoryName(from color: UIColor) -> String {
        switch color {
        case .systemOrange:
            return "Работа"
        case .taskGreen:
            return "Личное"
        case .systemPurple:
            return "Иное"
        default:
            return "work"
        }
    }
}
