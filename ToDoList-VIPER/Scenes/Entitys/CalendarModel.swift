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
        let dateModelsArray = daysArray.map { $0.convertDateModel(for: $0) }
        return dateModelsArray
    }
}
