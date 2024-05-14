//
//  UITextField + EXT.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 15.11.2023.
//

import UIKit

extension UITextField {
    static func createToDoTextField(text: String, textSize: CGFloat, weight: UIFont.Weight, color: UIColor, returnKey: UIReturnKeyType) -> UITextField {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.backgroundColor = color
        textField.font = UIFont.systemFont(ofSize: textSize, weight: weight)
        textField.placeholder = text
        textField.layer.cornerRadius = 10
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
        textField.returnKeyType = returnKey
        return textField
    }
}

//MARK: - Add bottom border extension

extension UITextField {
    func addBottomLine(width: CGFloat, color: UIColor) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.height - 3, width: self.frame.width, height: width)
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}

