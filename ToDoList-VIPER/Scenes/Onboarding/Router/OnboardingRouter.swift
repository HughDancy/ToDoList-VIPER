//
//  OnboardingRouter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 17.01.2024.
//

import UIKit

final class OnboardingRouter: OnboardingRouterProtocol {
  
    static func createOnboardingModule() -> UIViewController {
        let view = OnboardingController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        let presenter: OnboardingPresenterProtocol & OnboardingInteractorOutputProtocol = OnboardingPresenter()
        let interactor: OnboardingInteractorInputProtocol = OnboardingInteractor()
        let router = OnboardingRouter()
        let navCon = UINavigationController(rootViewController: view)
        navCon.tabBarController?.tabBar.isHidden = true
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
    
        return navCon
    }
    
    func goToLoginModule(from view: OnboardingViewProtocol) {
        guard let parrentView = view as? UIViewController else { return}
//        let loginController = LoginController()
//        parrentView.navigationController?.pushViewController(loginController, animated: true)
//        parrentView.present(loginController, animated: true)
    }
    
    func presentRequestAcess(from view: OnboardingViewProtocol) {
        guard let onboardingView = view as? UIViewController else { return }
        let interactor: OnboardingInteractorInputProtocol = OnboardingInteractor()
        let allertController = UIAlertController(title: "Разрешить доступ к медиа?",
                                                 message: "Наше приложение использует камеру и медиа библиотеку только для выбора аватара Вашей учетной        записи",
                                                 preferredStyle: .alert)
        let mediaAcessAction = UIAlertAction(title: "Разрешить доступ", style: .default) { action in
            interactor.checkPermissions()
        }
        
        let cancelAction = UIAlertAction(title: "Позже", style: .cancel)
        allertController.addAction(mediaAcessAction)
        allertController.addAction(cancelAction)
        onboardingView.present(allertController, animated: true)
    }
    
}
