//
//  MockLoginPresenter.swift
//  ToDoList-VIPERTests
//
//  Created by Борис Киселев on 08.08.2024.
//

import UIKit.UIViewController
@testable import ToDoList_VIPER

final class MockLoginPresenter: LoginPresenterProtocol {
    // MARK: - Props for tests
    var isLoginEmpty = false
    var isEmptyPassword = false
    var isEmailNotValid = false
    var isSucces = false
    var isDataWrong = false
    var isGoogleSignIn = false 

    // MARK: - Protocol props
    weak var view: ToDoList_VIPER.LoginViewProtocol?
    var interactor: ToDoList_VIPER.LoginInteractorInputProtocol?
    var router: ToDoList_VIPER.LoginRouterProtocol?

    func chekTheLogin(login: String?, password: String?) {
        interactor?.checkAutorizationData(login: login, password: password)
    }
    
    func goToForgottPassword() {}
    func goToRegistration() {}
    func googleSingIn() {
        guard let view = view else { return }
        interactor?.googleLogIn(with: view)
    }
    func appleSignIn() {}
    func changeState() {}
}

extension MockLoginPresenter: LoginInteractorOutputProtocol {
    func getVerificationResult(with: ToDoList_VIPER.LogInStatus) {
        switch with {
        case .emptyLogin:
            self.isLoginEmpty = true
        case .emptyPassword:
            self.isEmptyPassword = true
        case .googleSignInSucces:
            break
        case .notValidEmail:
            self.isEmailNotValid = true
        case .success:
            self.isSucces = true
        case .wrongEnteredData:
            self.isDataWrong = true
        }
    }
}
