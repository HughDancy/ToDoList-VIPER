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

extension UILabel {
    func strikeThrough(_ isStrikeThrough: Bool = true) {
        guard let text = self.text else {
            return
        }
        
        if isStrikeThrough {
            let attributeString =  NSMutableAttributedString(string: text)
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0,attributeString.length))
            self.attributedText = attributeString
        } else {
            let attributeString =  NSMutableAttributedString(string: text)
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: [], range: NSMakeRange(0,attributeString.length))
            self.attributedText = attributeString
        }
    }
}
