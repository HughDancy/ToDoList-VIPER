//
//  AddToDoRouter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 15.11.2023.
//

import UIKit

final class AddToDoRouter: AddToDoRouterProtocol {
    static func createAddToDoModule() -> UIViewController {
        let presenter: AddToDoPresenter = AddToDoPresenter()
        let view = AddToDoController()
        let interactor: AddToDoInteractorInputProtocol = AddToDoInteractor()
        let router: AddToDoRouterProtocol = AddToDoRouter()
        let navVc = UINavigationController(rootViewController: view)
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return navVc
    }
    
    
}
