//
//  ExecuteToDoRouter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 14.11.2023.
//

import UIKit

class ExecuteToDoRouter: ExecuteToDoRouterProtocol {
    static func createToDoListModule() -> UIViewController {
        let presenter: ExecuteToDoPresenterProtocol & ExecuteToDoInteractorOutputProtocol = ExecuteToDoPresenter()
        let interactor: ExecuteToDoInteractorInputProtocol = ExecuteToDoInteractor()
        let router: ExecuteToDoRouter = ExecuteToDoRouter()
        let vc = ExecuteToDoController()
        let navCon = UINavigationController(rootViewController: vc)

        vc.presenter = presenter
        presenter.view = vc
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter

        return vc
    }
}
