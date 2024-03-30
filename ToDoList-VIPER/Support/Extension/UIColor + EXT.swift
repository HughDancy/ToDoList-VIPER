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
            return .systemGreen
        case "systemPurple":
            return .systemPurple
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
        default:
            return "systemBlue"
        }
    }
}
