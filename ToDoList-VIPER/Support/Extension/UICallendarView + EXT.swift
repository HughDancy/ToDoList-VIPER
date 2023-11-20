//
//  UICallendarView + EXT.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 16.11.2023.
//

import UIKit

extension UICalendarView {
    static func createToDoCalendar() -> UICalendarView {
        let calendarView = UICalendarView()
        calendarView.calendar = .current
        calendarView.locale = .current
        return calendarView
    }
}
