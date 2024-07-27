//
//  HomeTabBarRouter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 14.11.2023.
//

import UIKit

final class HomeTabBarRouter: HomeTabBarRouterProtocol {
    
    func presentAddNewToDooScreen(from view: HomeTabBarViewProtocol) {
        guard let parrentViewController = view as? UIViewController else { return }
        let moduleBuilder = AssemblyBuilder()
        let addNewToDoModule = moduleBuilder.createAddNewToDoModule()
        addNewToDoModule.modalPresentationStyle = .custom
        addNewToDoModule.modalTransitionStyle = .flipHorizontal
        addNewToDoModule.transitioningDelegate = parrentViewController as? any UIViewControllerTransitioningDelegate
        parrentViewController.present(addNewToDoModule, animated: true)
    }
}
