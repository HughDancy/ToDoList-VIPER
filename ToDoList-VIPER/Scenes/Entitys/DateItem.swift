//
//  DateItem.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 28.03.2024.
//

import Foundation

struct DateItem {
    let date: Date
    let dayOfWeek: String
    let numberOfDay: String
    let monthName: String
    let dateString: String
    var isWorkTask: Bool?
    var isPersonalTask: Bool?
    var isOtherTask: Bool?
    
}
