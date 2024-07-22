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
//        interactor?.retriveUserData()
    }
    
    func updateUserData() {
        interactor?.retriveUserData()
    }
    
    func goToTodayToDos() {
        guard let view = view else { return }
        router?.goTodayToDos(from: view)
    }
    
    func goToTommorowToDos() {
        guard let view = view else { return }
        router?.goTomoorowToDos(from: view)
    }
    
    func goToDoneToDos() {
        guard let view = view else { return }
        router?.goToDoneToDos(from: view)
    }
    
    func goToOverdueToDos() {
        guard let view = view else { return }
        router?.goToOverdueToDos(from: view)
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
