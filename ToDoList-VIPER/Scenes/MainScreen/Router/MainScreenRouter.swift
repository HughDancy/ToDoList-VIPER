//
//  MainScreenRouter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 15.03.2024.
//

import UIKit

final class MainScreenRouter: MainScreenRouterProtocol {
 
    static func createMainScreenModule() -> UIViewController {
        let viewController = MainScreenController()
        let presenter: MainScreenPresenterProtocol & MainScreenInteractorOutputProtocol = MainScreenPresenter()
        let interactor: MainScreenInteractorInputProtocol = MainScreenInteractor()
        let router: MainScreenRouterProtocol = MainScreenRouter()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return viewController
    }
    
    func goToToDos(from view: any MainScreenViewProtocol, status: ToDoListStatus) {
        guard let parrentView = view as? UIViewController else { return }
        let toDosModule = ToDosRouter.createToDosModule(with: status)
        parrentView.navigationController?.pushViewController(toDosModule, animated: true)
    }
}

