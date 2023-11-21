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
    
    func presentToDoDetailScreen(from view: ToDoListViewProtocol, for toDoItem: ToDoItem) {
        let toDoDeatailVc = ToDoDetailRouter.createToDoDetailModule(with: toDoItem)
        toDoDeatailVc.hidesBottomBarWhenPushed = true
        guard let viewController = view as? UIViewController else { return }
        viewController.navigationController?.pushViewController(toDoDeatailVc, animated: true)
    }
    
    func goAddToDoScreen(from view: ToDoListViewProtocol) {
        let addToDoVc = AddToDoRouter.createAddToDoModule(with: view)
        guard let viewController = view as? UIViewController else { return }
        addToDoVc.modalPresentationStyle = .formSheet
        viewController.present(addToDoVc, animated: true)
    }
}
