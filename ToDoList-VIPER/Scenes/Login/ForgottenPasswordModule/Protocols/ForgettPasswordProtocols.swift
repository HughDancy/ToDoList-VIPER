//
//  ForgettPasswordProtocols.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 07.06.2024.
//

import UIKit

protocol ForgetPasswordViewProtocol: AnyObject {
    var presenter: ForgettPasswordPresenterProtocol? { get set }
}

protocol ForgettPasswordPresenterProtocol: AnyObject {
    var view: ForgetPasswordViewProtocol? { get set }
    var interactor: ForgettPasswordInreractorInputProtocol? { get set }
    var router: ForgettPasswordRouterProtocol? { get set }
    
    //VIEW -> PRESENTER
    func resetPassword(with email: String)
}

protocol ForgettPasswordInreractorInputProtocol: AnyObject {
    var presenter: ForgettPasswordInreractorOutputProtocol? { get set }
    
    //PRESENTER -> INTERACTOR
    func resetPassword(with email: String)
}

protocol ForgettPasswordInreractorOutputProtocol: AnyObject {
    //INTERACTOR -> PRESENTER
    func returnWelldone()
    func returnFailure()
    func returnNetworkError()
}

protocol ForgettPasswordRouterProtocol: AnyObject {
    static func createForgettPasswordModule() -> UIViewController
    
    func dismissToLoginScreen(from view: ForgetPasswordViewProtocol)
    func showWelldoneAlert(from view: ForgetPasswordViewProtocol)
    func showFailureAlert(from view: ForgetPasswordViewProtocol)
    func showNetworkErrorAlert(from view: ForgetPasswordViewProtocol)
}

