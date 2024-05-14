//
//  DateFormatter + EXT.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 20.11.2023.
//

import Foundation

extension DateFormatter {
    static func getStringFromDate(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .medium
        formatter.locale = Locale(identifier: "ru_RU")
        let date = formatter.string(from: date)
        return date
    }
    
    static func getDateFromString(_ date: String) -> Date {
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .medium
        formatter.timeZone = .current
        formatter.locale = Locale(identifier: "ru_RU")
        let dayDate = formatter.date(from: date) ?? Date.today
        return dayDate
    }
}
