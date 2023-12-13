//
//  OptionsRouter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 13.12.2023.
//

import UIKit

final class OptionsRouter: OptionsRouterProtocol {

    static func createOptionsModule() -> UIViewController {
        let presenter: OptionsPresenterProtocol & OptionsInteractorOutputProtocol = OptionsPresenter()
        let interactor: OptionsInteractorInputProtcol = OptionsInteractor()
        let viewController = OptionsViewController()
        let router = OptionsRouter()
        let navigationVc = UINavigationController(rootViewController: viewController)
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return navigationVc
        
    }
    
    func goToUserOptions(from view: OptionsViewProtocol) {
        print(view)
    }
    
    func goToNotifications(from view: OptionsViewProtocol) {
        print(view)
    }
    
    func goToFeedback(from view: OptionsViewProtocol) {
        print(view)
    }
    
    
}
