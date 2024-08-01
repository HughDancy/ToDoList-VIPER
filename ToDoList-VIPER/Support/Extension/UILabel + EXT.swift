//
//  UILabel + EXT.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 15.11.2023.
//

import UIKit

extension UILabel {
    static func createSimpleLabel(text: String, size: CGFloat, width: UIFont.Weight, color: UIColor, aligment: NSTextAlignment, numberLines: Int) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: size, weight: width)
        label.text = text
        label.textColor = color
        label.textAlignment = aligment
        label.numberOfLines = numberLines
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
            attributeString.addAttributes([
                NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.thick.rawValue,
                NSAttributedString.Key.strikethroughColor: UIColor.label,
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15.0, weight: .semibold)
            ], range: NSRange(location: 0, length: attributeString.length))
            self.attributedText = attributeString
        } else {
            let attributeString =  NSMutableAttributedString(string: text)
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: [], range: NSRange(location: 0, length: attributeString.length))
            self.attributedText = attributeString
        }
    }
}
