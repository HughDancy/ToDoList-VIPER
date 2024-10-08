//
//  MainScreenProtocols.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 15.03.2024.
//

import UIKit

protocol MainScreenViewProtocol: AnyObject {
    var presenter: MainScreenPresenterProtocol? { get set }
    func getUserName(_ userName: String)
    func getUserAvatar(_ userAvatar: URL?)
    func getToDosCount(_ toDosCount: [[String]])
}

protocol MainScreenPresenterProtocol: AnyObject {
    var view: MainScreenViewProtocol? { get set }
    var interactor: MainScreenInteractorInputProtocol? { get set }
    var router: MainScreenRouterProtocol? { get set }

    // VIEW -> PRESETNER
    func getToDosCount()
    func goToTodos(with status: ToDoListStatus)
    func updateUserData()
}

protocol MainScreenInteractorInputProtocol: AnyObject {
    var presenter: MainScreenInteractorOutputProtocol? { get set }
    var storage: MainScreenLocalStorageProtocol? { get set }
    var firebaseStorageManager: MainScreenServerStorageProtocol? { get set }

    // PRESENTER -> INTERACTOR
    func retriveUserAvatar()
    func retriveUserName()
    func getToDosCount()
}

protocol MainScreenInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func didRetriveUserName(_ name: String)
    func didRetriveUserAvatar(_ avatarUrl: URL?)
    func didRetriveToDosCount(_ info: [[String]])
}

protocol MainScreenRouterProtocol: AnyObject {
    // PRESENTER -> ROUTER
    func goToToDos(from view: MainScreenViewProtocol, status: ToDoListStatus)
}
