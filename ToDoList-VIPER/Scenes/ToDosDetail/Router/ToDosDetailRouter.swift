//
//  ToDosRouter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 03.04.2024.
//

import UIKit

final class ToDosDetailRouter: ToDosDetailRouterProtocol {
    weak var presenter: ToDosDetailInteractorOutputProtocol?
    
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
        router.presenter = presenter
        
        return viewController as! UIViewController
    }
    
    func showAllert(with view: any ToDosDetailViewProtocol, status: ToDoDetailStatus) {
        
        guard let currentView = view as? UIViewController else { return }
        
        switch status {
        case .allSave:
            let allertController = UIAlertController(title: nil,
                                                     message: "Изменения успешно сохранены!",
                                                     preferredStyle: .alert)
            allertController.addAction(UIAlertAction(title: "Ок", style: .cancel, handler: { _ in
                self.presenter?.didDeleteToDo()
            }))
            currentView.present(allertController, animated: true)
        case .delete:
            let allertController = UIAlertController(title: nil, message: "Вы действительно хотите удалить эту задачу?", preferredStyle: .alert)
            let deleteAction = UIAlertAction(title: "Да", style: .destructive) { _ in
                self.presenter?.didDeleteToDo()
            }
            let cancelAction = UIAlertAction(title: "Нет", style: .cancel)
            allertController.addAction(cancelAction)
            allertController.addAction(deleteAction)
            currentView.present(allertController, animated: true)
        case .error:
            let allertController = UIAlertController(title: "Ошибка",
                                                     message: "Произошла неизвестная ошибка. Попробуйте снова",
                                                     preferredStyle: .alert)
            allertController.addAction(UIAlertAction(title: "Ок", style: .cancel))
            currentView.present(allertController, animated: true)
        }
    }
    
    func goBackToTasks(with view: any ToDosDetailViewProtocol) {
        guard let currentView = view as? UIViewController else { return }
        currentView.navigationController?.popViewController(animated: true)
    }
}
