//
//  RegistrationRouter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 29.01.2024.
//

import UIKit

final class RegistrationRouter: RegistrationRouterProtocol {
    var presenter: RegistrationPresenterPtorocol?
    
    static func createRegistrationModule() -> UIViewController {
        let view = RegistrationController()
        let presenter: RegistrationPresenterPtorocol & RegistrationInteractorOutputProtocol = RegistrationPresenter()
        let interactor: RegistrationInteractorInputProtocol = RegistrationInteractor()
        let router: RegistrationRouterProtocol = RegistrationRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.presenter = presenter
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
    
    func showImageSourceAlert(from view:  RegistrationViewProtocol) {
        guard let registrationView = view as? UIViewController else { return }
        let allertController = UIAlertController(title: "Выберете источник",
                                                 message: "Выберете источник для аватара пользователя. Приложению понадобятся соответствующие разрешения",
                                                 preferredStyle: .alert)
        allertController.addAction(UIAlertAction(title: "Камера",
                                                 style: .default,
                                                 handler: {_ in 
                                                       self.presenter?.checkPermission(with: .camera)
                                                       print("User choose camera")
                                                           }))
        allertController.addAction(UIAlertAction(title: "Галлерея",
                                                 style: .default,
                                                 handler: {_ in 
                                                       self.presenter?.checkPermission(with: .gallery)
                                                       print("User choose gallery")
                                                           }))
        allertController.addAction(UIAlertAction(title: "Позже",
                                                 style: .cancel,
                                                 handler: {_ in 
                                                       print("User choose cancel")
                                                           }))
        registrationView.present(allertController, animated: true)
    }
    
    func goToOption(from view: any RegistrationViewProtocol, with label: String) {
        guard let registrationView = view as? UIViewController else { return }
        let alert = UIAlertController(title: "Открыть настройки",
                                      message: "Доступ к \(label) не предоставлен. Открыть настройки для предоставления доступа?",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Открыть настройки", style: .default, handler: { _ in
            UIApplication.shared.open(NSURL(string: UIApplication.openSettingsURLString)! as URL, options: [:], completionHandler: nil)
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        registrationView.present(alert, animated: true)
    }
}
