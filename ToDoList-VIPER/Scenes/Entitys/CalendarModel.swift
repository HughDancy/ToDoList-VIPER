//
//  CalendarModel.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 28.03.2024.
//

import Foundation
import UIKit.UIColor

class CalendarModel {
    func getDaysArray(date: Date) -> [Date] {
        var daysArray = [Date]()
        for day in -10...10 {
            let date = date.getDayOffset(with: day)
            daysArray.append(date)
        }
        return daysArray
    }
    
    func getWeekForCalendar(date: Date) -> [DateItem] {
        let daysArray = getDaysArray(date: date)
        var dateModelsArray = daysArray.map { $0.convertDateModel(for: $0) }
        let tasks = TaskStorageManager.instance.fetchDateRangeToDos(date: daysArray)
        
        let tempDateModelsArray = dateModelsArray
        for task in tasks {
            for (index, date) in tempDateModelsArray.enumerated() {
                if date.dateString == task.dateTitle ?? "" {
                    if task.color == .systemOrange {
                        dateModelsArray[index].isWorkTask = true
                    }
                    
                    if task.color == .taskGreen {
                        dateModelsArray[index].isPersonalTask = true
                    }
                    
                    if task.color == .systemPurple {
                        dateModelsArray[index].isOtherTask = true
                    }
                }
            }
        }
        return dateModelsArray
    }
}
