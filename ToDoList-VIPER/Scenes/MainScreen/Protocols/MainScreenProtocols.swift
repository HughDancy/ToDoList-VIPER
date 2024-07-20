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
    
    //VIEW -> PRESETNER
    func getToDosCount()
    func goToTodayToDos()
    func goToTommorowToDos()
    func goToDoneToDos()
    func goToOverdueToDos()
    func updateUserData()
}

protocol MainScreenInteractorInputProtocol: AnyObject {
    var presenter: MainScreenInteractorOutputProtocol? { get set }
    
    //PRESENTER -> INTERACTOR
    func retriveUserData()
    func getToDosCount()
}

protocol MainScreenInteractorOutputProtocol: AnyObject {
    //INTERACTOR -> PRESENTER
    func didRetriveUserName(_ name: String)
    func didRetriveUserAvatar(_ avatarUrl: URL?)
    func didRetriveToDosCount(_ info: [[String]])
}

protocol MainScreenRouterProtocol: AnyObject {
    static func createMainScreenModule() -> UIViewController
    
    //PRESENTER -> ROUTER
    func goTodayToDos(from view: MainScreenViewProtocol)
    func goTomoorowToDos(from view: MainScreenViewProtocol)
    func goToOverdueToDos(from view: MainScreenViewProtocol)
    func goToDoneToDos(from view: MainScreenViewProtocol)
}
