//
//  DateItem.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 28.03.2024.
//

import Foundation

struct DateItem {
    let dayOfWeek: String
    let numberOfDay: String
    let monthName: String
    let dateString: String
    var isWorkTask: Bool?
    var isPersonalTask: Bool?
    var isOtherTask: Bool?
    
//    mutating func changeStatus(with status: DateStatus) {
//        switch status {
//        case .isWork:
//            isWorkTask = true
//        case .isPersonal:
//            isPersonalTask = true
//        case .isOther:
//            isOtherTask = true
//        }
//    }
}

//enum DateStatus {
//    case isWork
//    case isPersonal
//    case isOther
//}
