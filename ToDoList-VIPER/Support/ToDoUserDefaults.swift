//
//  ToDoUserDefaults.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 13.12.2023.
//

import Foundation

enum Theme: String  {
   case light
   case dark
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
