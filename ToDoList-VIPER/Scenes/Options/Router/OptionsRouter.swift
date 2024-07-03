//
//  OptionsRouter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 03.07.2024.
//

import UIKit

final class OptionsRouter: OptionsRouterProtocol {
    //MARK: -
    
    static func createOptionsModule() -> UIViewController {
        let view = OptionsViewController()
        let presenter: OptionsPresenterProtocol & OptionsOutputInteractorProtocol = OptionsPresenter()
        let interactor: OptionsInputInteractorProtocol = OptionsInteractor()
        let router: OptionsRouterProtocol = OptionsRouter()
        let navCon = UINavigationController(rootViewController: view)
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.view = view
        presenter.router = router
        interactor.presenter = presenter
        
        return navCon
    }
    
    //MARK: - Router Methods
    func goToUserOptions(from view: OptionsViewProtocol) {
        guard let parrentView = view as? UIViewController else { return }
        parrentView.navigationController?.pushViewController(MockViewController(), animated: true)
    }
    
    func logOut(from view:  OptionsViewProtocol) {
        guard let parrentView = view as? UIViewController else { return }
        let loginModule = LoginRouter.createLoginModule()
        parrentView.navigationController?.pushViewController(loginModule, animated: true)
    }
    
    
}
