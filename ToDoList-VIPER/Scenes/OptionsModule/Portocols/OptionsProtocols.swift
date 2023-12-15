//
//  OptionsProtocols.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 13.12.2023.
//

import UIKit

protocol OptionsViewProtocol: AnyObject {
    var presenter: OptionsPresenterProtocol? { get set }
    func getOptionsData(items: [OptionsItems])
    
}

protocol OptionsPresenterProtocol: AnyObject {
    var view: OptionsViewProtocol? { get set }
    var interactor: OptionsInteractorInputProtcol? { get set }
    var router: OptionsRouterProtocol? { get set }
    
    //MARK: - VIEW -> PRESENTER
    func viewWillAppear()
    func changeTheme(with bool: Bool)
    func goToNotification()
    func goToFeedback()
    func goToUserOptions()
}

protocol OptionsInteractorInputProtcol: AnyObject {
    var presenter: OptionsInteractorOutputProtocol? { get set }
    
    //MARK: - PRESENTER -> INTERACTOR
    func changeUserTheme(with bool: Bool)
    func showOptionsItems()
}

protocol OptionsInteractorOutputProtocol: AnyObject {
    //MARK: - INTERACTOR -> PRESENTER
    func showOptionsData(items: [OptionsItems])
}

protocol OptionsRouterProtocol: AnyObject {
    static func createOptionsModule() -> UIViewController
    
    //MARK: - PRESENTER -> ROUTER
    func goToUserOptions(from view: OptionsViewProtocol)
    func goToNotifications(from view: OptionsViewProtocol)
    func goToFeedback(from view: OptionsViewProtocol)
}

protocol SwitchThemeProtocol: AnyObject {
    func changeUserTheme(with bool: Bool)
}

protocol GoToUserOptionsProtocol: AnyObject {
    func goToUserOptions() 
}
