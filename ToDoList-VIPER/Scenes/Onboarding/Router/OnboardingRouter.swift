//
//  OnboardingRouter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 17.01.2024.
//

import UIKit

final class OnboardingRouter: OnboardingRouterProtocol {
   weak var presenter: OnboardingPresenterProtocol?
    
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
        router.presenter = presenter
        interactor.presenter = presenter
        
        return navCon
    }
    
    func goToLoginModule(from view: OnboardingViewProtocol) {
        guard let parrentView = view as? UIViewController else { return}
        let loginModule = LoginRouter.createLoginModule() 
        parrentView.navigationController?.pushViewController(loginModule, animated: true)
    }
    
    func presentRequestAcess(from view: OnboardingViewProtocol) {
        guard let onboardingView = view as? UIViewController else { return }
        let allertController = UIAlertController(title: "Разрешить доступ к медиа?",
                                                 message: "Наше приложение использует камеру и медиа библиотеку только для выбора аватара Вашей учетной        записи",
                                                 preferredStyle: .alert)
        allertController.addAction(UIAlertAction(title: "Разрешить доступ", style: .default) { action in
            self.presenter?.checkAccess()
        })
        allertController.addAction(UIAlertAction(title: "Позже", style: .cancel))
        onboardingView.present(allertController, animated: true)
    }
    
    func openSettings(from view: OnboardingViewProtocol, label: String) {
        guard let onboardingView = view as? UIViewController else { return }
        let alert = UIAlertController(title: "Открыть настройки",
                                      message: "Доступ к \(label) не предоставлен. Открыть настройки для предоставления доступа?",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Открыть настройки", style: .default, handler: { _ in
            UIApplication.shared.open(NSURL(string: UIApplication.openSettingsURLString)! as URL, options: [:], completionHandler: nil)
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        onboardingView.present(alert, animated: true)
    }
    
}
