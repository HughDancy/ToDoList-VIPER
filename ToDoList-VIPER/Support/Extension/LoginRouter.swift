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
    }
    
    func goToMainScreen(from view: LoginViewProtocol) {
        guard let view = view as? UIViewController else { return}
        let mainModule = HomeTabBarRouter.createHomeTabBar()
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
