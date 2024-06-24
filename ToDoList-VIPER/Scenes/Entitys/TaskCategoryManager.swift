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
    func getCategory(from color: UIColor) -> Category {
        switch color {
        case .systemOrange:
            return Category.work
        case .taskGreen:
            return Category.personal
        case .systemPurple:
            return Category.other
        default:
            return Category.other
        }
    }
}

extension TaskCategoryManager {
    func getCategoryData(from category: Category) -> (String, UIColor) {
        switch category {
        case .work:
            return ("briefcase", .systemOrange)
        case .personal:
            return ("person", .taskGreen)
        case .other:
            return ("books.vertical.circle", .systemPurple)
        }
    }
}


