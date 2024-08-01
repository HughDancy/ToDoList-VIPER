//
//  Date + EXT.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 29.11.2023.
//

import Foundation

extension Date {
   static var tomorrow: Date { return Date().dayAfter }

   static var today: Date {
       var calendar = Calendar.current
       calendar.timeZone = .current
       let date = calendar.startOfDay(for: Date())
       return date }

    static var yesterday: Date {
        let yersterday =  Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        return yersterday
    }
   var dayAfter: Date {
      return Calendar.current.date(byAdding: .day, value: 1, to: Date())!
   }
}

extension Date {
    // MARK: - Standart DateFormatter
    private func getFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter
    }

    // MARK: - Get week day
     func getWeekDay(date: Date) -> String {
        let formatter = getFormatter()
        formatter.dateFormat = "EEEEEE"
        let weekDay = formatter.string(from: date)
        return weekDay
    }

    // MARK: - Get fay of week
    private func getNumberDayOfWeek(date: Date) -> String {
        var calendar = Calendar.current
        calendar.timeZone = .current
        let dayOfWeek = "\(calendar.component(.day, from: date))"
        return dayOfWeek
    }

    // MARK: - Get month name
    private func getMonthName(date: Date) -> String {
        let formatter = date.getFormatter()
        formatter.dateFormat = "MMMM"
        let month = formatter.string(from: date)
        return month
    }

    // MARK: - Get year name
    func getYear(date: Date) -> Int {
        var calendar = Calendar.current
        calendar.timeZone = .current
        let currentYear = calendar.component(.year, from: date)
        return currentYear
    }

    // MARK: - Get day offset
    public func getDayOffset(with offset: Int) -> Date {
        var calendar = Calendar.current
        calendar.timeZone = .current
        let date = calendar.date(byAdding: .day, value: offset, to: self) ?? Date()
        return date
    }

    // MARK: - Convert to DateItem
    func convertDateModel(for date: Date) -> DateItem {
        let dayOfWeek = getWeekDay(date: date)
        let numberOfDay = getNumberDayOfWeek(date: date)
        return DateItem(date: date,
                        dayOfWeek: dayOfWeek,
                        numberOfDay: numberOfDay,
                        monthName: getMonthName(date: date),
                        dateString: dateFormattedMMyyyy())
    }

    // MARK: Get dateFormatedMMyyyy
    public func dateFormattedMMyyyy() -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .medium
        formatter.locale = Locale(identifier: "ru_RU")
        let test = formatter.string(from: self)
        return test
    }
}

extension Date {
    static func getDateFromStatus(_ status: ToDoListStatus) -> Date {
        switch status {
        case .today, .done:
            Date.today
        case .tommorow:
            Date.tomorrow
        case .overdue:
            Date.yesterday
        }
    }
}
