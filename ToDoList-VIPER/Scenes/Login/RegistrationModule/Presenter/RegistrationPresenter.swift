//
//  RegistrationPresenter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 29.01.2024.
//

import Foundation

final class RegistrationPresenter: RegistrationPresenterPtorocol {
    weak var view: RegistrationViewProtocol?
    var interactor: RegistrationInteractorInputProtocol?
    var rotuter: RegistrationRouterProtocol?
    
    func registerNewUser(with name: String, email: String, password: String) {
        interactor?.registerNewUser(name: name, email: email, password: password)
    }
    
    func showAllert(status: RegistrationStatus) {
        guard let view = view else { return }
        rotuter?.showAlert(with: status, and: view)
    }
}

extension RegistrationPresenter: RegistrationInteractorOutputProtocol {
    func getRegistrationResult(result: RegistrationStatus)  {
        guard let view = self.view else { return }
        switch result {
        case .complete:
            self.rotuter?.showAlert(with: .complete, and: view)
        case .emptyFields:
            self.rotuter?.showAlert(with: .emptyFields, and: view)
            self.view?.stopAnimateRegisterButton()
        case .notValidEmail:
            self.rotuter?.showAlert(with: .notValidEmail, and: view)
            self.view?.stopAnimateRegisterButton()
        case .connectionLost:
            self.rotuter?.showAlert(with: .connectionLost, and: view)
            self.view?.stopAnimateRegisterButton()
        case .error:
            self.rotuter?.showAlert(with: .error, and: view)
            self.view?.stopAnimateRegisterButton()
        }
    }
}
