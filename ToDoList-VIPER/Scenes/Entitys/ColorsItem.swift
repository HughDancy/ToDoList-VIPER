//
//  ColorsItem.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 16.03.2024.
//

import UIKit

struct ColorsItem {
    var color: UIColor
    static let colorsStack: [UIColor] = [.systemRed, .systemBlue, .systemOrange, .systemYellow, .systemMint]
}

enum ColorsItemResult: String {
    case systemRed
    case systemBlue
    case systemOrange
    case systemYellow
    case systemMint
}
