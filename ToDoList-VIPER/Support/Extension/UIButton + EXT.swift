//
//  UIButton + EXT.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 19.07.2024.
//

import UIKit.UIButton
import UIKit.UIColor

extension UIButton {
    static func createPlainButton(text: String, tintColor: UIColor, backgoroundColor: UIColor) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(text, for: .normal)
        button.backgroundColor = backgoroundColor
        button.tintColor = tintColor
        return button
    }
}
