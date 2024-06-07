//
//  ForgettPasswordRouter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 07.06.2024.
//

import UIKit

final class ForgettPasswordRouter: ForgettPasswordRouterProtocol {
    
    static func createForgettPasswordModule() -> UIViewController {
        let view = ForgottPasswordController()
        let presenter: ForgettPasswordPresenterProtocol & ForgettPasswordInreractorOutputProtocol = ForgettPasswortPresenter()
        let interactor: ForgettPasswordInreractorInputProtocol = ForgettPasswordInteractor()
        let router: ForgettPasswordRouterProtocol = ForgettPasswordRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return view
    }
    
    func dismissToLoginScreen(from view: ForgetPasswordViewProtocol) {
        guard let currentView = view as? UIViewController else { return }
        currentView.navigationController?.popViewController(animated: true)
    }
    
    func showWelldoneAlert(from view: ForgetPasswordViewProtocol) {
        guard let currentView = view as? UIViewController else { return }
        let allertController = CustomAlertController()
        allertController.modalPresentationStyle = .overCurrentContext
        allertController.modalTransitionStyle = .crossDissolve
        currentView.present(allertController, animated: true)
        allertController.present(
            type: .oneButton,
            title: "Успешно!",
            message: "Ссылка для сброса старого пароля и установки нового отправлена на указанный Вами email - адрес",
            imageName: "saveDone",
            colorOne: .systemCyan,
            colorTwo: nil,
            buttonText: "Ок",
            buttonTextTwo: nil) { _ in
                self.dismissToLoginScreen(from: view)
            }
    }
    
    func showFailureAlert(from view: ForgetPasswordViewProtocol) {
        guard let currentView = view as? UIViewController else { return }
        let allertController = CustomAlertController()
        allertController.modalPresentationStyle = .overCurrentContext
        allertController.modalTransitionStyle = .crossDissolve
        currentView.present(allertController, animated: true)
        allertController.present(
            type: .oneButton,
            title: "Ошибка",
            message: "Произошла неизвестная ошибка. Проверьте введенный Вами адрес электронной почты, не содержит ли он ошибок. Либо, попробуйте позже",
            imageName: "error",
            colorOne: .systemCyan,
            colorTwo: nil,
            buttonText: "Ок",
            buttonTextTwo: nil) { _ in }
    }
    
    func showNetworkErrorAlert(from view: ForgetPasswordViewProtocol) {
        guard let currentView = view as? UIViewController else { return }
        let allertController = CustomAlertController()
        allertController.modalPresentationStyle = .overCurrentContext
        allertController.modalTransitionStyle = .crossDissolve
        currentView.present(allertController, animated: true)
        allertController.present(
            type: .oneButton,
            title: "Ошибка сети",
            message: "Произошла ошибка сети. Проверьте Ваше подключение к интернету и попробуйте снова",
            imageName: "error",
            colorOne: .systemCyan,
            colorTwo: nil,
            buttonText: "Ок",
            buttonTextTwo: nil) { _ in }
    }
}
