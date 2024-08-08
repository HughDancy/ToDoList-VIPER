//
//  ForgettPasswordInteractor.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 07.06.2024.
//

import Foundation

final class ForgettPasswordInteractor: ForgettPasswordInreractorInputProtocol {
    weak var presenter: ForgettPasswordInreractorOutputProtocol?
    var authManager: ForgottPasswordProtocol?

    func resetPassword(with email: String) {
        if  email == "" || email.isValidEmail() == false {
            presenter?.returnResult(with: .failure)
        }

        authManager?.resetPassword(email: email, compelition: { [weak self] status in
            switch status {
            case .failure:
                self?.presenter?.returnResult(with: .failure)
            case .networkError:
                self?.presenter?.returnResult(with: .networkError)
            case .wellDone:
                self?.presenter?.returnResult(with: .wellDone)
            }
        })
    }
}
