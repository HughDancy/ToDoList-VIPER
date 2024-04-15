//
//  UIColor + EXT.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 30.03.2024.
//

import UIKit

extension UIColor {
    static func convertStringToColor(_ string: String) -> UIColor {
        switch string {
        case "systemOrange":
            return .systemOrange
        case "systemGreen":
            return UIColor(named: "taskGreen") ?? .systemGreen
        case "systemPurple":
            return .systemPurple
        case "taskGreen":
            return UIColor(named: "taskGreen") ?? .systemGreen
        default:
            return .systemMint
        }
    }
    
    static func convertColorToString(_ color: UIColor) -> String {
        switch color {
        case .systemOrange:
            return "systemOrange"
        case .systemGreen:
            return "systemGreen"
        case .systemPurple:
            return "systemPurple"
        case UIColor(named: "taskGreen"):
            return "taskGreen"
        default:
            return "systemBlue"
        }
    }
}
