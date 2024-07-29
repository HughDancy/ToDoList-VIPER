//
//  ToDoTask.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 18.06.2024.
//

import Foundation
import UIKit.UIColor

struct ToDoTask: Codable {
    var title: String
    var descriptionTitle: String
    var date: Date
    var category: Category
    var status: ProgressStatus
    var id: UUID
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case descriptionTitle = "description"
        case date = "date"
        case category = "category"
        case status = "status"
        case id = "id"
    }
}

enum ProgressStatus: String, Codable {
    case inProgress = "In progress"
    case done = "Done"
    case fail = "Fail"
    
    var value: String {
        return rawValue
    }
    
    static func convertStatusFromServer(serverStatus: ProgressStatus, date: Date) -> Bool {
        let statusFromServer = serverStatus != ProgressStatus.done && serverStatus != ProgressStatus.inProgress
        let dateStatus = date >= Date.today
        return statusFromServer == dateStatus
    }
    
    static func convertStatusForServer(task: ToDoObject) -> ProgressStatus {
        if task.isOverdue == true {
            return .fail
        } else if task.doneStatus == true {
            return .done
        } else {
            return .inProgress
        }
    }
}

enum Category: String, Codable {
    case work = "work"
    case personal = "personal"
    case other = "other"
    
    var value: String {
        return rawValue
    }
}
