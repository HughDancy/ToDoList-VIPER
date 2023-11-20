//
//  DateFormatter + EXT.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 20.11.2023.
//

import Foundation

extension DateFormatter {
    static func createMediumDate(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.locale = .current
        let date = dateFormatter.string(from: date)
        return date
    }
}
