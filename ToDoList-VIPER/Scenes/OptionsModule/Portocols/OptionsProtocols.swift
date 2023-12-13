//
//  OptionsProtocols.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 13.12.2023.
//

import Foundation

protocol OptionsViewProtocol: AnyObject {
    var presenter: OptionsPresenterProtocol? { get set }
    
}

protocol OptionsPresenterProtocol: AnyObject {
    var view: OptionsViewProtocol? { get set }
    var interactor: OptionsInteractorProtcol? { get set }
    var router: OptionsRouterProtocol? { get set }
    
    //MARK: - VIEW -> PRESENTER
    func changeTheme(with: Bool)
    func goToNotification()
    func goToFeedback()
    func goToUserOptions()
}

protocol OptionsInteractorProtcol: AnyObject {
    
    //MARK: - PRESENTER -> INTERACTOR
    func changeUserTheme(with: Bool)
}

protocol OptionsRouterProtocol: AnyObject {
    static func createOptionsModule() -> ViewController
    
    //MARK: - PRESENTER -> ROUTER
    func goToUserOptions()
    func goToNotifications()
    func goToFeedback()
}
