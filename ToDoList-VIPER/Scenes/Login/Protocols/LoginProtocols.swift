//
//  LoginProtocols.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 24.01.2024.
//

import UIKit

protocol LoginViewProtocol: AnyObject {
    var presenter: LoginPresenterProtocol? { get set }
    //PRESENTER -> VIEW
    func makeAnimateTextField(with state: LogInStatus)
    func stopAnimateLoginButton()
    
}

protocol LoginPresenterProtocol: AnyObject {
    var view: LoginViewProtocol? { get set }
    var interactor: LoginInteractorInputProtocol? { get set }
    var router: LoginRouterProtocol? { get set }
    
    //VIEW -> PRESENTER
    func chekTheLogin(login: String?, password: String?)
    func goToRegistration()
    func googleSingIn()
    func appleSignIn()
    func changeState()
}

protocol LoginInteractorInputProtocol: AnyObject {
    var presenter: LoginInteractorOutputProtocol? { get set }
    
    //PRESENTER -> INTERACTOR
    func checkAutorizationData(login: String?, password: String?)
    func changeOnboardingState()
    func googleLogIn(with contoller: LoginViewProtocol)
}

protocol LoginInteractorOutputProtocol: AnyObject {
    //INTERACTOR -> PRESENTER
    func getVerificationResult(with: LogInStatus)
}

protocol LoginRouterProtocol: AnyObject {
    static func createLoginModule() -> UIViewController
    func goToRegistration(from view: LoginViewProtocol)
    func goToMainScreen(from view: LoginViewProtocol)
    func showAllert(from view: LoginViewProtocol, title: String, message: String)
    func signInWithApple(with: LoginViewProtocol)
}


enum LogInStatus {
    case success
    case notValidEmail
    case emptyLogin
    case emptyPassword
    case wrongEnteredData
}
