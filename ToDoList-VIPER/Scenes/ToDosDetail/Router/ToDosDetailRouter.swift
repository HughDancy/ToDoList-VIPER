//
//  ToDosRouter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 03.04.2024.
//

import UIKit

final class ToDosDetailRouter: ToDosDetailRouterProtocol {
    static func createModule(with toDo: ToDoObject) -> UIViewController {
        let viewController: ToDosDetailViewProtocol = ToDosDetailController()
        let presenter: ToDosDetailPresenterProtocol & ToDosDetailInteractorOutputProtocol = ToDosDetailPresenter()
        let interactor: ToDosDetailInteractorInputProtocol = ToDosDetailInteractor()
        let router: ToDosDetailRouterProtocol = ToDosDetailRouter()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        interactor.toDoItem = toDo
        
        return viewController as! UIViewController
    }
    
    func showAllert(with view: any ToDosDetailViewProtocol) {
        guard let currentView = view as? UIViewController else { return }
        let allertController = UIAlertController(title: "Ошибка",
                                                 message: "Произошла неизвестная ошибка. Попробуйте снова",
                                                 preferredStyle: .alert)
        allertController.addAction(UIAlertAction(title: "Ок", style: .cancel))
        currentView.present(allertController, animated: true)
    }
    
    func goBackToTasks(with view: any ToDosDetailViewProtocol) {
        guard let currentView = view as? UIViewController else { return }
        currentView.dismiss(animated: true)
    }
}
