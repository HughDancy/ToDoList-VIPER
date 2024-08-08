//
//  CalendarModel.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 28.03.2024.
//

import Foundation
import UIKit.UIColor

final class CalendarModel {
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
            for (index, date) in tempDateModelsArray.enumerated() where date.dateString == task.dateTitle ?? "" {
                switch task.color {
                case .systemOrange:
                    dateModelsArray[index].isWorkTask = true
                case .taskGreen:
                    dateModelsArray[index].isPersonalTask = true
                case .systemPurple:
                    dateModelsArray[index].isOtherTask = true
                default:
                    dateModelsArray[index].isOtherTask = true

                }
            }
        }
        return dateModelsArray
    }
}
