//
//  CABasicAnimation + EXT.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 26.01.2024.
//

import UIKit

extension CABasicAnimation {
    static func createShakeAnimation(for view: UIView, keyPath: String) -> CABasicAnimation {
       let animation = CABasicAnimation(keyPath: keyPath)
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: view.center.x - 10, y: view.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: view.center.x + 10, y: view.center.y))
        return animation
    }
}
