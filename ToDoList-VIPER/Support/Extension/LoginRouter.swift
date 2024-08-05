//
//  LoginRouter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 26.01.2024.
//

import UIKit

final class LoginRouter: LoginRouterProtocol {
    private let moduleBuilder = AssemblyBuilder()

    func goToForgottPasswordModule(from view: any LoginViewProtocol) {
        guard let view = view as? UIViewController else { return }
        let forgottPasswordModule = moduleBuilder.createForgettPasswordModule()
        view.navigationController?.pushViewController(forgottPasswordModule, animated: true)
    }

    func goToRegistration(from view: LoginViewProtocol) {
        guard let view = view as? UIViewController else { return }
        let registrationModule = moduleBuilder.createRegistrationModule()
        view.navigationController?.pushViewController(registrationModule, animated: true)
    }

    func goToMainScreen(from view: LoginViewProtocol) {
        guard let view = view as? UIViewController else { return}
        NewUserCheck.shared.setIsNotNewUser()
        let startDate = Calendar.current.startOfDay(for: Date.today)
        UserDefaults.standard.setValue(startDate, forKey: UserDefaultsNames.lastOverdueRefresh.name)
        UserDefaults.standard.setValue(true, forKey: UserDefaultsNames.firstWorkLaunch.name)
        let mainScreen = UINavigationController(rootViewController: moduleBuilder.createMainScreenModule())
        let optionScreen = moduleBuilder.createOptionsModule()
        let mainModule = moduleBuilder.createHomeTabBar(tabOne: mainScreen, tabTwo: optionScreen)
        mainModule.modalTransitionStyle = .crossDissolve
        mainModule.modalPresentationStyle = .fullScreen
        view.present(mainModule, animated: true)
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
