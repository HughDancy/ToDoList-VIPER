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
    
    func completeAndGoBack() {
        guard let view = view else { return }
        rotuter?.dismissRegister(from: view)
    }
}

extension RegistrationPresenter: RegistrationInteractorOutputProtocol {
    func getRegistrationResult(result: RegistrationStatus)  {
        switch result {
        case .complete:
            guard let view = self.view else { return }
            self.rotuter?.dismissRegister(from: view)
        default:
            print("Something wrong")
        }
//        rotuter?.showAlert(with: result)
    }
}
