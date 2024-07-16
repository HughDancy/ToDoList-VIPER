//
//  LoginRouter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 26.01.2024.
//

import UIKit

final class LoginRouter: LoginRouterProtocol {
  
    static func createLoginModule() -> UIViewController {
//        let viewController = LoginController()
        let viewController = LoginController()
//        let navController = UINavigationController(rootViewController: viewController)
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
    
    func goToForgottPasswordModule(from view: any LoginViewProtocol) {
        guard let view = view as? UIViewController else { return }
        let forgottPasswordModule = ForgettPasswordRouter.createForgettPasswordModule()
        view.navigationController?.pushViewController(forgottPasswordModule, animated: true)
    }
    
    
    func goToRegistration(from view: LoginViewProtocol) {
        guard let view = view as? UIViewController else { return }
        let registrationModule = RegistrationRouter.createRegistrationModule()
        view.navigationController?.pushViewController(registrationModule, animated: true)
    }
    
    func goToMainScreen(from view: LoginViewProtocol) {
        guard let view = view as? UIViewController else { return}
//        let mainModule = HomeTabBarRouter.createHomeTabBar()
        NewUserCheck.shared.setIsNotNewUser()
        let mainScreen = MainScreenRouter.createMainScreenModule()
        let optionScreen = OptionsRouter.createOptionsModule()
        let mainModule = HomeTabBarRouter.createNewTabBarRouter(tabOne: mainScreen, tabTwo: optionScreen)
        view.navigationController?.pushViewController(mainModule, animated: true)
    }
    
    func showAllert(from view: LoginViewProtocol, title: String, message: String) {
        guard let view = view as? UIViewController else { return }
        let allertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        allertController.addAction(UIAlertAction(title: "Ок", style: .cancel))
        view.present(allertController, animated: true)
    }
    
    func signInWithApple(with controller: LoginViewProtocol) {
        guard let view = controller as? UIViewController else { return }
        let allertController = UIAlertController(title: "Сорян",
                                                 message: """
                                                 У меня пока нет платного аккаунта разработчика Apple, поэтому я не смог реализовать функцию SignIn with Apple.
                                                 Воспользуйтесь обычной формой Sign In или "Войти с помощью Google". Спасибо за понимание!
                                                 """,
                                                 preferredStyle: .alert)
        allertController.addAction(UIAlertAction(title: "Понятно", style: .cancel))
        view.present(allertController, animated: true)
    }
}
