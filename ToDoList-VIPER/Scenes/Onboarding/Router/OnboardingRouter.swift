//
//  OnboardingRouter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 17.01.2024.
//

import UIKit

final class OnboardingRouter: OnboardingRouterProtocol {
    static func createOnboardingModule() -> UIViewController {
        let view = OnboardingPagesController(transitionStyle: .scroll, navigationOrientation: .horizontal)
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
        let loginModule = LoginRouter.createLoginModule() 
        parrentView.navigationController?.pushViewController(loginModule, animated: true)
    }
}
