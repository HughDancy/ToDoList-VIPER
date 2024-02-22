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
    
    func showAlert(with result: RegistrationStatus, and view: RegistrationViewProtocol) {
        let alertController = UIAlertController(title: "", message: nil, preferredStyle: .alert)
        guard let view = view as? UIViewController else { return }
        switch result {
        case .complete:
            alertController.title = "Регистрация прошла успешно!"
            alertController.addAction(UIAlertAction(title: "Ок", style: .default, handler: { _ in
                view.navigationController?.popViewController(animated: true)
            }))
            view.present(alertController, animated: true)
        case .connectionLost:
            alertController.title = "Проеврьте соединение с интернетом"
            alertController.addAction(UIAlertAction(title: "Ок", style: .cancel))
            view.present(alertController, animated: true)
        case .notValidEmail:
            alertController.title = "Введен невалидный email. Пожалуйста, попробуйте снова"
            alertController.addAction(UIAlertAction(title: "Ок", style: .cancel))
            view.present(alertController, animated: true)
        case .emptyFields:
            alertController.title = "Вы не заполнили обязательные для регистрации поля"
            alertController.addAction(UIAlertAction(title: "Ок", style: .cancel))
            view.present(alertController, animated: true)
        case .error:
            alertController.title = "Обнаружена неизвестная ошибка. Пожалуйста, попробуйте снова"
            alertController.addAction(UIAlertAction(title: "Ок", style: .cancel))
            view.present(alertController, animated: true)
        }
    }
}
