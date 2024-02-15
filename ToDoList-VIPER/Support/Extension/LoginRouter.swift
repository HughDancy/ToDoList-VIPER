//
//  LoginRouter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 26.01.2024.
//

import UIKit

final class LoginRouter: LoginRouterProtocol {
    static func createLoginModule() -> UIViewController {
        let viewController = LoginController()
        let navController = UINavigationController(rootViewController: viewController)
        let presenter: LoginPresenterProtocol & LoginInteractorOutputProtocol = LoginPresenter()
        let interactor: LoginInteractorInputProtocol = LoginInteractor()
        let router: LoginRouterProtocol = LoginRouter()
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        viewController.navigationItem.hidesBackButton = true
        return viewController
    }
    
    func goToRegistration(from view: LoginViewProtocol) {
        guard let view = view as? UIViewController else { return }
        let registrationModule = RegistrationRouter.createRegistrationModule()
        view.navigationController?.pushViewController(registrationModule, animated: true)
    }
    
    func goToMainScreen(from view: LoginViewProtocol) {
        guard let view = view as? UIViewController else { return}
        let mainModule = HomeTabBarRouter.createHomeTabBar()
//        view.navigationController?.pushViewController(mainModule, animated: true)
        mainModule.modalTransitionStyle = .crossDissolve
        mainModule.modalPresentationStyle = .fullScreen
        view.navigationController?.present(mainModule, animated: true)
        
    }
    
    func showWrongPasswordAllert(from view: LoginViewProtocol) {
        guard let view = view as? UIViewController else { return }
        let alertController = UIAlertController(title: "Ошибка",
                                                message: "Введен неверный логин или пароль. Попробуйте снова",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ок", style: .cancel))
        view.present(alertController, animated: true)
    }
    
    
    
    
}
