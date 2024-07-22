//
//  MainScreenPresenter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 15.03.2024.
//

import Foundation

final class MainScreenPresenter: MainScreenPresenterProtocol {
    weak var view: MainScreenViewProtocol?
    var interactor: MainScreenInteractorInputProtocol?
    var router: MainScreenRouterProtocol?
    
    func getToDosCount() {
        interactor?.getToDosCount()
    }
    
    func goToTodos(with status: ToDoListStatus) {
        guard let view = view else { return }
        router?.goToToDos(from: view, status: status)
    }
    
    func updateUserData() {
        interactor?.retriveUserData()
    }
}

extension MainScreenPresenter: MainScreenInteractorOutputProtocol {
    func didRetriveUserName(_ name: String) {
        view?.getUserName(name)
    }
    
    func didRetriveUserAvatar(_ avatarUrl: URL?) {
        view?.getUserAvatar(avatarUrl)
    }
        
    func didRetriveToDosCount(_ info: [[String]]) {
        view?.getToDosCount(info)
    }
}
