//
//  UIButton + EXT.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 15.11.2023.
//

import UIKit

extension UIButton {
    static func createToDoButton(title: String, backColor: UIColor, tintColor: UIColor) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.backgroundColor = backColor
        button.tintColor = tintColor
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }
}


