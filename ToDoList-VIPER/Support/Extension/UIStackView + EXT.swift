//
//  UIStackView + EXT.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 29.03.2024.
//

import UIKit

extension UIStackView {
    func removeAllArrangedSubViews() {
        for view in self.arrangedSubviews {
            self.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }
}
