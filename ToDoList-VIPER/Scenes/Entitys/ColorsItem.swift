//
//  ColorsItem.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 16.03.2024.
//

import UIKit

struct ColorsItem {
    var color: UIColor
    static let colorsStack: [UIColor] = [.systemOrange, .systemGreen, .systemMint]
}

enum ColorsItemResult: String {
    case systemOrange
    case systemGreen
    case systemMint
}
