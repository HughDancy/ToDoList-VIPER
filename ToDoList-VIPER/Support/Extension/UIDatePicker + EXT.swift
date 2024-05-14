//
//  UIDatePicker + EXT.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 20.11.2023.
//

import UIKit

extension UIDatePicker {
    static func createToDoPicker() -> UIDatePicker {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .inline
        picker.locale = .current
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.local
        picker.calendar = calendar
        return picker
    }
}
