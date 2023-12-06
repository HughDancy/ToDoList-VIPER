//
//  OptionsItems.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 06.12.2023.
//

import Foundation

enum OptionsTitles: String {
    case lightDarkTheme = "Тема оформления"
    case notifications = "Уведомления"
    case feedback = "Обратная связь"
}

struct OptionsItems {
    var icon: String
    var title: String
}

extension OptionsItems {
    static let options = [
        OptionsItems(icon: "", title: OptionsTitles.lightDarkTheme.rawValue),
        OptionsItems(icon: "", title: OptionsTitles.notifications.rawValue),
        OptionsItems(icon: "", title: OptionsTitles.feedback.rawValue)
    ]
}
