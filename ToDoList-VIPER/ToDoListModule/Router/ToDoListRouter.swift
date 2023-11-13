//
//  ToDoListRouter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 09.11.2023.
//

import UIKit

class ToDoListRouter: ToDoListRouterProtocol {
    
    
    static func createToDoListModule() -> UIViewController {
        let presenter: ToDoListPresenterProtocol & ToDoListInteractorOutputProtocol = ToDoListPresenter()
        let interactor: ToDoListInteractorInputProtocol = ToDoListInteractor()
        let router = ToDoListRouter()
        let vc = ToDoListViewController()
        let navCon = UINavigationController(rootViewController: vc)
        
        vc.presenter = presenter
        presenter.view = vc
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
      
        return navCon
    }
    
    func presentToDoDetailScreen(from view: ToDoListViewProtocol, for: ToDoItem) {
//        let toDoDeatailVc = ToDoDetailRouter.
    }
    
    
}
