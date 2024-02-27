//
//  LoginProtocols.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 24.01.2024.
//

import UIKit

protocol LoginViewProtocol: AnyObject {
    var presenter: LoginPresenterProtocol? { get set }
    
}

protocol LoginPresenterProtocol: AnyObject {
    var view: LoginViewProtocol? { get set }
    var interactor: LoginInteractorInputProtocol? { get set }
    var router: LoginRouterProtocol? { get set }
    
    //VIEW -> PRESENTER
    func chekTheLogin(login: String, password: String)
    func goToRegistration()
    func googleSingIn()
    func changeState()
}

protocol LoginInteractorInputProtocol: AnyObject {
    var presenter: LoginInteractorOutputProtocol? { get set }
    
    //PRESENTER -> INTERACTOR
    func checkAutorizationData(login: String, password: String)
    func changeOnboardingState()
    func googleLogIn(with: LoginViewProtocol)
}

protocol LoginInteractorOutputProtocol: AnyObject {
    //INTERACTOR -> PRESENTER
    func getVerificationResult(with: Bool)
}

protocol LoginRouterProtocol: AnyObject {
    static func createLoginModule() -> UIViewController
    func goToRegistration(from view: LoginViewProtocol)
    func goToMainScreen(from view: LoginViewProtocol)
    func showWrongPasswordAllert(from view: LoginViewProtocol)
}
