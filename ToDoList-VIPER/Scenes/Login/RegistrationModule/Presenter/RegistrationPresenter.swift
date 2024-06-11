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
    var router: RegistrationRouterProtocol?
    
    func registerNewUser(with name: String, email: String, password: String) {
        interactor?.registerNewUser(name: name, email: email, password: password)
    }
    
    func showAllert(status: RegistrationStatus) {
        guard let view = view else { return }
        router?.showAlert(with: status, and: view)
    }
    
    func chooseImageSource() {
        guard let view = view else { return }
        router?.showImageSourceAlert(from: view)
    }
    
    func checkPermission(with status: PermissionStatus) {
        interactor?.checkPermission(with: status)
    }
}

extension RegistrationPresenter: RegistrationInteractorOutputProtocol {
    func getRegistrationResult(result: RegistrationStatus)  {
        guard let view = self.view else { return }
        self.router?.showAlert(with: result, and: view)
        self.view?.stopAnimateRegisterButton()
    }
    
    func goToOptions(with label: String) {
        guard let view = view else { return }
        router?.goToOption(from: view, with: label)
    }
    
    func goToImagePicker(with status: PermissionStatus) {
        guard let view = view else { return }
        router?.goToImagePicker(from: view, status: status)
    }
}
