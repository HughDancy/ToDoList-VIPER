//
//  MainScreenProtocols.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 15.03.2024.
//

import UIKit

protocol MainScreenViewProtocol: AnyObject {
    var presenter: MainScreenPresenterProtocol? { get set }
    func getUserData(_ : [String])
    func getToDosCount(_ : [Int])
}

protocol MainScreenPresenterProtocol: AnyObject {
    var view: MainScreenViewProtocol? { get set }
    var interactor: MainScreenInteractorInputProtocol? { get set }
    var router: MainScreenRouterProtocol? { get set }
    
    //VIEW -> PRESETNER
    func viewWillAppear()
    func goToTodayToDos()
    func goToTommorowToDos()
    func goToDoneToDos()
    func goToOverdueToDos()
}

protocol MainScreenInteractorInputProtocol: AnyObject {
    var presenter: MainScreenInteractorOutputProtocol? { get set }
    
    //PRESENTER -> INTERACTOR
    func retriveUserData()
    func getToDosCount()
}

protocol MainScreenInteractorOutputProtocol: AnyObject {
    //INTERACTOR -> PRESENTER
    func didRetriveUserData(_ info: [String])
    func didRetriveToDosCount(_ info: [Int])
}

protocol MainScreenRouterProtocol: AnyObject {
    static func createMainScreenModule() -> UIViewController
    
    //PRESENTER -> ROUTER
    func goTodayToDos(from view: MainScreenViewProtocol)
    func goTomoorowToDos(from view: MainScreenViewProtocol)
    func goToOverdueToDos(from view: MainScreenViewProtocol)
    func goToDoneToDos(from view: MainScreenViewProtocol)
}
