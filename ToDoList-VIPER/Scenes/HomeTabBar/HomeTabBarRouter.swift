//
//  HomeTabBarRouter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 14.11.2023.
//

import UIKit

final class HomeTabBarRouter: HomeTabBarRouterProtocol {
    static func createHomeTabBar() -> UITabBarController {

        let tabBar = CustomHomeTabBarController()
        let taskScreen = ToDoListRouter.createToDoListModule()
        taskScreen.hidesBottomBarWhenPushed = false
        let taskScreenItem = UITabBarItem(title: "Задачи",
                                          image: UIImage(systemName: "list.clipboard.fill"),
                                          tag: 0)
        taskScreen.tabBarItem = taskScreenItem
        
        let optionsScreen = ViewController()
        let optionsScreenItem = UITabBarItem(title: "Опции",
                                             image: UIImage(systemName: "gearshape.fill"),
                                             tag: 1)
        optionsScreen.tabBarItem = optionsScreenItem
        
        tabBar.viewControllers = [taskScreen, optionsScreen]
        
//        let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
//        appDelegate.window?.rootViewController = tabBar
      
        return tabBar
    }
}
