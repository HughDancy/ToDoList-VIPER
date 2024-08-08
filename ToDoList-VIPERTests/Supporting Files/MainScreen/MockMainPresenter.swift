//
//  MockMainPresenter.swift
//  ToDoList-VIPERTests
//
//  Created by Борис Киселев on 02.08.2024.
//

import UIKit
@testable import ToDoList_VIPER

class MockMainPresenter: MainScreenPresenterProtocol {
    // MARK: - Test props
    var nameIsRetrive = false
    var userAvatarIsRetrive = false
    var todosCoutnIsRetrive = false
    var toDosCount: [[String]] = [[""]]
    // MARK: - Protocol props
    weak var view: ToDoList_VIPER.MainScreenViewProtocol?
    var interactor: ToDoList_VIPER.MainScreenInteractorInputProtocol?
    var router: ToDoList_VIPER.MainScreenRouterProtocol?
    
    func getToDosCount() {
        interactor?.getToDosCount()
    }
    
    func goToTodos(with status: ToDoList_VIPER.ToDoListStatus) { }

    func updateUserData() {
        interactor?.retriveUserAvatar()
        interactor?.retriveUserName()
    }
}

extension MockMainPresenter: MainScreenInteractorOutputProtocol {
    func didRetriveUserName(_ name: String) {
        self.nameIsRetrive = true
    }
    
    func didRetriveUserAvatar(_ avatarUrl: URL?) {
        self.userAvatarIsRetrive = true
    }
    
    func didRetriveToDosCount(_ info: [[String]]) {
        self.todosCoutnIsRetrive = true
        self.toDosCount = info
    }
}
