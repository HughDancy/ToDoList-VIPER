//
//  UILabel + EXT.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 15.11.2023.
//

import UIKit

extension UILabel {
    static func createToDoLabel(fontSize: CGFloat, weight: UIFont.Weight) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
        label.textAlignment = .left
        return label
    }
}
