//
//  HomeTabBarPresenter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 15.03.2024.
//

import UIKit

final class HomeTabBarPresenter: HomeTabBarPresenterProtocol {
    weak var view:  HomeTabBarViewProtocol?
    var router:  HomeTabBarRouterProtocol?
    
    func presentAddNewToDo() {
        guard let view = view else { return }
        router?.presentAddNewToDooScreen(from: view)
    }
}
