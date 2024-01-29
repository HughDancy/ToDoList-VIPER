//
//  RegistrationRouter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 29.01.2024.
//

import UIKit

final class RegistrationRouter: RegistrationRouterProtocol {
    static func createRegistrationModule() -> UIViewController {
        let view = RegistrationController()
        let presenter: RegistrationPresenterPtorocol & RegistrationInteractorOutputProtocol = RegistrationPresenter()
        let interactor: RegistrationInteractorInputProtocol = RegistrationInteractor()
        let router: RegistrationRouterProtocol = RegistrationRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.rotuter = router
        interactor.presenter = presenter
        return view
    }
    
    func showAlert(with result: RegistrationStatus) {
        switch result {
        case .complete:
            print("complete")
        case .connectionLost:
            print("connection lost")
        case .emptyFields:
            print("Some fields are empty")
        case .error:
            print("Some error")
        }
    }
    
    func dismissRegister(from view: RegistrationViewProtocol) {
        guard let view = view as? UIViewController else { return }
        view.dismiss(animated: true)
    }
}
