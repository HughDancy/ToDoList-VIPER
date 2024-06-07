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
    
    func chekTheLogin(login: String?, password: String?) {
        interactor?.checkAutorizationData(login: login, password: password)
    }
    
    func goToForgottPassword() {
        guard let view = view else { return }
        router?.goToForgottPasswordModule(from: view)
    }
    
    func goToRegistration() {
        guard let view = view else { return }
        router?.goToRegistration(from: view)
    }
    
    func changeState() {
        interactor?.changeOnboardingState()
    }
    
    func googleSingIn() {
        guard let view = view else { return }
        interactor?.googleLogIn(with: view)
    }
    
    func appleSignIn() {
        guard let view = view else { return }
        router?.signInWithApple(with: view)
    }
}

extension LoginPresenter: LoginInteractorOutputProtocol {
    func getVerificationResult(with: LogInStatus) {
        guard let view = view else { return }
        switch with {
        case .emptyLogin:
            self.view?.makeAnimateTextField(with: .emptyLogin)
            self.view?.stopAnimateLoginButton()
        case .emptyPassword:
            self.view?.makeAnimateTextField(with: .emptyPassword)
            self.view?.stopAnimateLoginButton()
        case .notValidEmail:
            self.router?.showAllert(from: view, title: "Ошибка", 
                                    message: """
                                    Введен невалидный e-mail. Поробуйте снова
                                    """)
            self.view?.stopAnimateLoginButton()
        case .wrongEnteredData:
            self.router?.showAllert(from: view, title: "Ошибка",
                                    message: """
                                    Введен неверный логин или пароль. Попробуйте снова
                                    """)
            self.view?.stopAnimateLoginButton()
        case .success:
            self.router?.goToMainScreen(from: view)
        }
    }
}
