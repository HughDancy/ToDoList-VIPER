//
//  HomeTabBarRouter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 14.11.2023.
//

import UIKit

final class HomeTabBarRouter: HomeTabBarRouterProtocol {
    static func createHomeTabBar() -> UITabBarController {
        let tabBar = UITabBarController()
        
        let planned = ToDoListRouter.createToDoListModule()
        planned.hidesBottomBarWhenPushed = false
        let plannedItem = UITabBarItem(title: "Запланировано",
                                       image: UIImage(systemName: "list.bullet.clipboard"),
                                       selectedImage: UIImage(systemName: "list.bullet.clipboard.fill"))
        
        planned.tabBarItem = plannedItem
        
        let executed = ViewController()
        let execudetItem = UITabBarItem(title: "Выполненно",
                                        image: UIImage(systemName: "circle.badge.checkmark"),
                                        selectedImage: UIImage(systemName: "circle.badge.checkmark.fill"))
        executed.tabBarItem = execudetItem
        
        let configuarations = ViewController()
        let configurationsItem = UITabBarItem(title: "Настройки",
                                              image: UIImage(systemName: "gear.circle"),
                                              selectedImage: UIImage(systemName: "gear.circle.fill"))
        configuarations.tabBarItem = configurationsItem
        
        tabBar.viewControllers = [planned, executed, configuarations]
        tabBar.tabBar.tintColor = .systemIndigo
        
        return tabBar
    }
    
    
}
