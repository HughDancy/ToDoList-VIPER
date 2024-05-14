//
//  ToDosRouter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 30.03.2024.
//

import UIKit

final class ToDosRouter: ToDosRouterProtocol {

    static func createToDosModule(with status: ToDoListStatus) -> UIViewController {
        let view = ToDoController()
        let presenter: ToDosPresenterProtocol & ToDosInteractorOutputProtocol = ToDosPresenter()
        let interactor: ToDosInteractorInputProtocol = ToDosInteractor()
        let router: ToDosRouterProtocol = ToDosRouter()
        
        presenter.status = status
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return view
    }
    
    func goToTask(_ task: ToDoObject, from view: any ToDosViewProtocol) {
        guard let parrentView = view as? UIViewController else { return }
        let toDoDetailModule = ToDosDetailRouter.createModule(with: task)
        let detailModule = ToDosDetailController()
        detailModule.item = task
        parrentView.navigationController?.pushViewController(toDoDetailModule, animated: true)
    }
}
