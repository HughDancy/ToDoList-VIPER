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
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return view
    }
    
    func navigateBackToListViewController(from view: AddToDoViewProtocol) {
        guard let view = view as? UIViewController else { return }
        view.navigationController?.popViewController(animated: true)
    }
    
}
