//
//  HomeTabBarRouterProtocol.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 14.11.2023.
//

import UIKit

protocol HomeTabBarRouterProtocol: AnyObject {
    static func createHomeTabBar() -> UITabBarController
}
