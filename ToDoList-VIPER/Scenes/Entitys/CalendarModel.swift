//
//  CalendarModel.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 28.03.2024.
//

import Foundation

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
        let tasks = ToDoStorage.instance.fetchToDos()
//        dateModelsArray.forEach { dateItem in
//            if tasks.contains(where: { task in
//                dateItem.dateString == DateFormatter.createMediumDate(from: task.date ?? Date.today)
//            }) {
//                print("Hoola")
//            }
//        }
      let tempDateModelsArray = dateModelsArray
        for task in tasks {
            for (index, date) in tempDateModelsArray.enumerated() {
                if date.dateString == task.dateTitle ?? "" {
                    if task.color == "systemOrange" {
                        dateModelsArray[index].isWorkTask = true
                    }
                    
                    if task.color == "systemGreen" {
                        dateModelsArray[index].isPersonalTask = true
                    }
                    
                    if task.color == "systemPurple" {
                        dateModelsArray[index].isOtherTask = true
                    }
                }
            }
        }
        
        return dateModelsArray
    }
    
}
