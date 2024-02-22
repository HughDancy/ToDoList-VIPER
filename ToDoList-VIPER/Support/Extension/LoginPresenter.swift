//
//  LoginPresenter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 26.01.2024.
//

import Foundation

final class LoginPresenter: LoginPresenterProtocol {
    weak var view: LoginViewProtocol?
    var interactor: LoginInteractorInputProtocol?
    var router: LoginRouterProtocol?
    
    func chekTheLogin(login: String, password: String) {
        interactor?.checkAutorizationData(login: login, password: password)
    }
    
    func goToRegistration() {
        guard let view = view else { return }
        router?.goToRegistration(from: view)
    }
    
    func changeState() {
        interactor?.changeOnboardingState()
    }
}

extension LoginPresenter: LoginInteractorOutputProtocol {
    func getVerificationResult(with: Bool) {
        guard let view = view else { return }
        if with == true {
            self.router?.goToMainScreen(from: view)
        } else {
            self.router?.showWrongPasswordAllert(from: view)
        }
    }
}
