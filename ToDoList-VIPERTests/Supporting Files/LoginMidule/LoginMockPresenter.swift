//
//  LoginMockPresenter.swift
//  ToDoList-VIPERTests
//
//  Created by Борис Киселев on 02.08.2024.
//

import UIKit
@testable import ToDoList_VIPER

class LoginMockPresenter: LoginPresenterProtocol {
    // MARK: - Test props
    var emptyLogin = false
    var emptyPass = false
    var notValidEmail = false
    var result: ToDoList_VIPER.LogInStatus? = nil

    // MARK: - Protocol props
    weak var view: ToDoList_VIPER.LoginViewProtocol?
    var interactor: ToDoList_VIPER.LoginInteractorInputProtocol?
    var router: ToDoList_VIPER.LoginRouterProtocol?

    func chekTheLogin(login: String?, password: String?) {
        interactor?.checkAutorizationData(login: login, password: password)
    }
    
    func goToForgottPassword() { }
    func goToRegistration() { }
    func googleSingIn() {}
    func appleSignIn() { }
    func changeState() {}
}

extension LoginMockPresenter: LoginInteractorOutputProtocol {
    func getVerificationResult(with: ToDoList_VIPER.LogInStatus) {
        switch with {
        case .emptyLogin:
            self.emptyLogin = true
        case .emptyPassword:
            self.emptyPass = true
        case .googleSignInSucces:
               break
        case .notValidEmail:
            self.notValidEmail = true
        case .success:
            self.result = .success
        case .wrongEnteredData:
            break
        }
    }
}
