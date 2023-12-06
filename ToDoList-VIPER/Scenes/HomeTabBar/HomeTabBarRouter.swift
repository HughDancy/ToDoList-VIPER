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
                                       image: UIImage(systemName: "square.3.layers.3d"),
                                       selectedImage: UIImage(systemName: "square.3.layers.3d.top.filled"))
        
        planned.tabBarItem = plannedItem
        
        let overdue = OverdueToDoRouter.createOverdueModule()
        let overdueItem = UITabBarItem(title: "Просроченно",
                                       image: UIImage(systemName: "square.stack.3d.up.slash"),
                                       selectedImage: UIImage(systemName: "square.stack.3d.up.slash.fill"))
        overdue.tabBarItem = overdueItem
        
        let executed = ExecuteToDoRouter.createToDoListModule()
        let execudetItem = UITabBarItem(title: "Выполненно",
                                        image: UIImage(systemName: "circle.badge.checkmark"),
                                        selectedImage: UIImage(systemName: "circle.badge.checkmark.fill"))
        executed.tabBarItem = execudetItem
        
        let testNavVa = UINavigationController(rootViewController: OptionsViewController())
        let configuarations = testNavVa
//        ViewController()
        let configurationsItem = UITabBarItem(title: "Настройки",
                                              image: UIImage(systemName: "gear.circle"),
                                              selectedImage: UIImage(systemName: "gear.circle.fill"))
        configuarations.tabBarItem = configurationsItem
        
        tabBar.viewControllers = [planned, overdue,  executed, configuarations]
        tabBar.tabBar.tintColor = .systemBlue
        
        return tabBar
    }
    
    
}
