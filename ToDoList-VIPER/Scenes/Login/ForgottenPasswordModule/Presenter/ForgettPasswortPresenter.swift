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
    var router: ForgettPasswordRouterProtocol?

    func resetPassword(with email: String) {
        interactor?.resetPassword(with: email)
    }
}

extension ForgettPasswortPresenter: ForgettPasswordInreractorOutputProtocol {
    func returnResult(with status: ResetStatus) {
        guard let view = view else { return }
        router?.showAlert(from: view, status: status)
    }
}
