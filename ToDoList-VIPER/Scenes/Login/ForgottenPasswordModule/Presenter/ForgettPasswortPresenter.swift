//
//  ForgettPasswortPresenter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 07.06.2024.
//

import UIKit

final class ForgettPasswortPresenter: ForgettPasswordPresenterProtocol {
    weak var view: ForgetPasswordViewProtocol?
    var interactor: ForgettPasswordInreractorInputProtocol?
    var router:  ForgettPasswordRouterProtocol?
    
    func resetPassword(with email: String) {
        interactor?.resetPassword(with: email)
    }
}

extension ForgettPasswortPresenter: ForgettPasswordInreractorOutputProtocol {
    func dismissToLogin() {
        guard let view = view else { return }
        router?.dismissToLoginScreen(from: view)
    }
    
    func returnWelldone() {
        guard let view = view else { return }
        router?.showWelldoneAlert(from: view)
    }
    
    func returnFailure() {
        guard let view = view else { return }
        router?.showFailureAlert(from: view)
    }
    
    func returnNetworkError() {
        guard let view = view else { return }
        router?.showNetworkErrorAlert(from: view)
    }
}
