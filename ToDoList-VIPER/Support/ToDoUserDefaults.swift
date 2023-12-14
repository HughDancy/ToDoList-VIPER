//
//  ToDoUserDefaults.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 13.12.2023.
//

import UIKit

enum Theme: String  {
   case light
   case dark
    
    func getUserInterfaceStyle() -> UIUserInterfaceStyle  {
        switch self {
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}


struct ToDoUserDefaults {
    static var shares = ToDoUserDefaults()
    
    var theme: Theme {
        get {
            Theme(rawValue: UserDefaults.standard.string(forKey: "selectedTheme") ?? "light") ?? .light
        }
        set {
            UserDefaults.standard.setValue(newValue.rawValue, forKey: "selectedTheme")
        }
    }
}
