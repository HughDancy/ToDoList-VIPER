//
//  Date + EXT.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 29.11.2023.
//

import Foundation

extension Date {
   static var tomorrow:  Date { return Date().dayAfter }
   static var today: Date {return Date()}
   var dayAfter: Date {
      return Calendar.current.date(byAdding: .day, value: 1, to: Date())!
   }
}

extension Date {
    //MARK: - Standart DateFormatter
    private func getFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter
    }
    
    //MARK: - Get week day
     func getWeekDay(date: Date) -> String {
        let formatter = getFormatter()
        formatter.dateFormat = "EEEEEE"
        let weekDay = formatter.string(from: date)
        return weekDay
    }
    
    //MARK: - Get fay of week
    private func getNumberDayOfWeek(date: Date) -> String {
        let calendar = Calendar.current
        let dayOfWeek = "\(calendar.component(.day, from: date))"
        return dayOfWeek
    }
    
    //MARK: - Get month name
    private func getMonthName(date: Date) -> String {
        let formatter = date.getFormatter()
        formatter.dateFormat = "MMMM"
        let month = formatter.string(from: date)
        return month
    }

    //MARK: - Get year name
    func getYear(date: Date) -> Int {
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: date)
        return currentYear
    }
    
    //MARK: - Get day offset
    public func getDayOffset(with offset: Int) -> Date {
        let calendar = Calendar.current
        let date = calendar.date(byAdding: .day, value: offset, to: self) ?? Date()
        return date
    }
    
    //MARK: - Convert to DateItem
    func convertDateModel(for date: Date) -> DateItem {
        let dayOfWeek = getWeekDay(date: date)
        let numberOfDay = getNumberDayOfWeek(date: date)
        return DateItem(dayOfWeek: dayOfWeek,
                        numberOfDay: numberOfDay,
                        monthName: getMonthName(date: date),
                        dateString: dateFormattedMMyyyy())
    }
    
    //MARK: Get dateFormatedMMyyyy
    public func dateFormattedMMyyyy() -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .medium
        formatter.locale = Locale(identifier: "ru_RU")
        let test = formatter.string(from: self)
        return test
    }
}
