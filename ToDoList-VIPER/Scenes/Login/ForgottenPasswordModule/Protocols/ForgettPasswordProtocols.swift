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
    func returnResult(with status: ResetStatus)
}

protocol ForgettPasswordRouterProtocol: AnyObject {
    func dismissToLoginScreen(from view: ForgetPasswordViewProtocol)
    func showAlert(from view: ForgetPasswordViewProtocol, status: ResetStatus)
}

enum ResetStatus {
    case wellDone
    case failure
    case networkError
}
