//
//  OnboardingRouter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 17.01.2024.
//

import UIKit

final class OnboardingRouter: OnboardingRouterProtocol {
   
    
    static func createOnboardingModule() -> UIViewController {
        let view = WelcomeController()
        let presenter: OnboardingPresenterProtocol = OnboardingPresenter()
        let interactor: OnboardingInteractorProtocol = OnboardingInteractor()
        let router = OnboardingRouter()
        let navCon = UINavigationController(rootViewController: view)
        navCon.tabBarController?.tabBar.isHidden = true
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
    
        return navCon
    }
    
    func goToLoginScreen(from view: WelcomeViewProtocol) {
        guard let parrentView = view as? UIViewController else { return}
        let loginController = LoginController()
        parrentView.navigationController?.pushViewController(loginController, animated: true)
//        parrentView.present(loginController, animated: true)
    }
    
    
}
