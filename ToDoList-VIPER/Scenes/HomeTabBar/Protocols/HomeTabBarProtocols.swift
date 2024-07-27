//
//  HomeTabBarProtocols.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 15.03.2024.
//

import UIKit

protocol HomeTabBarViewProtocol: AnyObject {
    var presenter: HomeTabBarPresenterProtocol? { get set }
}

protocol HomeTabBarPresenterProtocol: AnyObject {
    var view: HomeTabBarViewProtocol? { get set}
    var router: HomeTabBarRouterProtocol? { get set }
    
    //VIEW -> PRESENTER
    func presentAddNewToDo()
}

protocol HomeTabBarRouterProtocol: AnyObject {
 
    //PRESENTER -> ROUTER
    func presentAddNewToDooScreen(from view: HomeTabBarViewProtocol)
}
