//
//  UINavigationController + EXT.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 03.04.2024.
//

import UIKit

extension UINavigationController {
    func addCustomBackButton(title: String = "Назад") {
        let backButton = UIBarButtonItem()
        backButton.title = title
        navigationBar.topItem?.backBarButtonItem = backButton
    }
}
