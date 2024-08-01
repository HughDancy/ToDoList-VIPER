//
//  UIColor + EXT.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 30.03.2024.
//

import UIKit

extension UIColor {
    var coreImageColor: CIColor {
        return CIColor(color: self)
    }
    var components: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        let coreImageColor = self.coreImageColor
        return (coreImageColor.red, coreImageColor.green, coreImageColor.blue, coreImageColor.alpha)
    }
}

extension UIColor {
    static func convertStringToColor(_ string: String) -> UIColor {
        switch string {
        case "systemOrange":
            return .systemOrange
        case "taskGreen":
            return UIColor(named: "taskGreen") ?? .systemGreen
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
        case UIColor(named: "taskGreen"):
            return "taskGreen"
        case .systemPurple:
            return "systemPurple"
        default:
            return "systemBlue"
        }
    }

    static func getColorFromDict(dict: [String: Any]) -> UIColor? {
        guard let red = dict["red"] as? NSNumber,
              let green = dict["green"] as? NSNumber,
              let blue = dict["blue"] as? NSNumber,
              let alpha = dict["alpha"] as? NSNumber else {
            return nil
        }

        return UIColor(red: CGFloat(truncating: red),
                       green: CGFloat(truncating: green),
                       blue: CGFloat(truncating: blue),
                       alpha: CGFloat(truncating: alpha))
    }

    static func getDictFromColor(color: UIColor) -> [String: Any] {
        let color = color.coreImageColor
        let redValue = color.red
        let greenValue = color.green
        let blueValue = color.blue
        let alphaValue = color.alpha

        return ["red" : redValue,
                "green" : greenValue,
                "blue" : blueValue,
                "alpha" : alphaValue
        ]
    }
}
