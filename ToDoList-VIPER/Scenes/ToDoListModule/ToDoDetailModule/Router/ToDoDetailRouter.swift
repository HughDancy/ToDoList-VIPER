//
//  ToDoDetailRouter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 13.11.2023.
//

import UIKit

class ToDoDetailRouter: ToDoDetailRouterProtocol {

    func navigateBackToListViewController(from view: ToDoDetailViewProtocol) {
        guard let view = view as? UIViewController else { return }
        view.navigationController?.popViewController(animated: true)
    }

    static func createToDoDetailModule(with toDo: ToDoObject) -> UIViewController {
        let view = ToDoDetailController()
        let presenter: ToDoDetailPresenterProtocol & TodoDetailInteractorOutputProtocol = ToDoDetailPresenter()
        let interactor: TodoDetailInteractorInputProtocol = ToDoDetailInteractor()
        let router: ToDoDetailRouterProtocol = ToDoDetailRouter()
        view.presenter = presenter
        presenter.view = view
        interactor.toDoItem = toDo
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        return view

    }

}
