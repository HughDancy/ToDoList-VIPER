//
//  UITextField + EXT.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 15.11.2023.
//

import UIKit

extension UITextField {
    static func createToDoTextField() -> UITextField {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 13, height: 0))
        textField.leftView = view
        textField.leftViewMode = .always
        textField.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        textField.backgroundColor = .systemGray6
            
        return textField
    }
    
    static func createDetailTextField(textSize: CGFloat, weight: UIFont.Weight, color: UIColor, borderStyle: BorderStyle, interaction: Bool) -> UITextField {
        let label = UITextField()
        label.borderStyle = .none
        label.isUserInteractionEnabled = false
        label.font = UIFont.systemFont(ofSize: textSize, weight: weight)
        label.textColor = .systemBlue
        return label
    }
    
    static func createBasicTextField(textSize: CGFloat, weight: UIFont.Weight, borderStyle: BorderStyle, returnKey: UIReturnKeyType, tag: Int) -> UITextField {
        let textField = UITextField()
        textField.borderStyle = borderStyle
        textField.font = UIFont.systemFont(ofSize: textSize, weight: weight)
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        textField.leftView = view
        textField.leftViewMode = .always
        textField.returnKeyType = returnKey
        textField.tag = tag
        textField.autocapitalizationType = .none
        return textField
    }

}

