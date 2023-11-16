//
//  UILabel + EXT.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 15.11.2023.
//

import UIKit

extension UILabel {
    static func createToDoLabel(fontSize: CGFloat, weight: UIFont.Weight, title: String) -> UILabel {
        let label = UILabel()
        label.text = title
        label.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
        label.textColor = .systemBlue
        label.textAlignment = .left
        return label
    }
}
