//
//  ToDoUserDefaults.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 04.07.2024.
//

import UIKit

enum Theme: String {
   case light
   case dark

    func getUserInterfaceStyle() -> UIUserInterfaceStyle {
        switch self {
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}

struct ToDoThemeDefaults {
    static var shared = ToDoThemeDefaults()

    var theme: Theme {
        get {
            Theme(rawValue: UserDefaults.standard.string(forKey: "selectedTheme") ?? "light") ?? .light
        }
        set {
            UserDefaults.standard.setValue(newValue.rawValue, forKey: "selectedTheme")
        }
    }

}
