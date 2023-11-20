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
}
