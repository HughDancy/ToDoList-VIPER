//
//  ToDosRouter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 03.04.2024.
//

import UIKit

final class ToDosDetailRouter: ToDosDetailRouterProtocol {
    weak var presenter: ToDosDetailInteractorOutputProtocol?

    func showAllert(with view: any ToDosDetailViewProtocol, status: ToDoDetailStatus) {
        guard let currentView = view as? UIViewController else { return }
        let allertController = CustomAlertController()
        allertController.modalPresentationStyle = .overCurrentContext
        allertController.modalTransitionStyle = .crossDissolve

        switch status {
        case .allSave:
            currentView.present(allertController, animated: true)
            allertController.present(type: .oneButton,
                                     title: "Сохранено",
                                     message: "Изменения успешно сохранены",
                                     imageName: "saveDone",
                                     colorOne: .systemCyan,
                                     colorTwo: nil,
                                     buttonText: "Ок",
                                     buttonTextTwo: nil) { _ in
                self.presenter?.didDeleteToDo()
            }
        case .delete:
            currentView.present(allertController, animated: true)
            allertController.present(
                type: .twoButtons,
                title: "Удалить",
                message: "Вы действительно хотите удалить эту задачу?",
                imageName: "deleteToDo",
                colorOne: .systemCyan,
                colorTwo: .systemRed,
                buttonText: "Отмена",
                buttonTextTwo: "Да") { state in
                    if state == true {
                        self.presenter?.deleteToDo()
                    }
                }
        case .error:
            currentView.present(allertController, animated: true)
            allertController.present(
                type: .oneButton,
                title: "Ошибка",
                message: "Произошла неизвестная ошибка. Попробуйте снова",
                imageName: "error",
                colorOne: .systemCyan,
                colorTwo: nil,
                buttonText: "Ок",
                buttonTextTwo: nil,
                handler: {_ in }
            )
        }
    }

    func goBackToTasks(with view: any ToDosDetailViewProtocol) {
        guard let currentView = view as? UIViewController else { return }
        currentView.navigationController?.popViewController(animated: true)
    }
}
