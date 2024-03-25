//
//  HomeTabBarRouter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 14.11.2023.
//

import UIKit

final class HomeTabBarRouter: HomeTabBarRouterProtocol {
    static func createHomeTabBar() -> UIViewController {
        let tabBar = CustomHomeTabBarController()
        let presenter: HomeTabBarPresenterProtocol = HomeTabBarPresenter()
        let router: HomeTabBarRouterProtocol = HomeTabBarRouter()
        
        let taskScreen = MainScreenRouter.createMainScreenModule()
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
        tabBar.presenter = presenter
        presenter.view = tabBar
        presenter.router = router
        
        return tabBar
    }
    
    func presentAddNewToDooScreen(from view: HomeTabBarViewProtocol) {
        guard let parrentViewController = view as? UIViewController else { return }
        let addNewToDoModule = AddNewToDoRouter.createAddNewToDoModule()
//        let addNewToDoModule = AddToDoRouter.createAddToDoModule(with: ToDoListController())
//        let toDoList = ToDoListRouter.createToDoListModule()
        addNewToDoModule.modalPresentationStyle = .custom
        addNewToDoModule.modalTransitionStyle = .flipHorizontal
//        toDoList.modalPresentationStyle = .custom
        addNewToDoModule.transitioningDelegate = parrentViewController as? any UIViewControllerTransitioningDelegate
        parrentViewController.present(addNewToDoModule, animated: true)
    }
}
