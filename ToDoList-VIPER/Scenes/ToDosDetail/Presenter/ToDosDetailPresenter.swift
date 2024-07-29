//
//  ToDosDetailPresenter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 03.04.2024.
//

import UIKit

final class ToDosDetailPresenter: ToDosDetailPresenterProtocol {
    weak var view: ToDosDetailViewProtocol?
    var interactor: ToDosDetailInteractorInputProtocol?
    var router: ToDosDetailRouterProtocol?
    
    func getToDo() {
        guard let task = interactor?.toDoItem else { return }
        view?.showToDoItem(task)
    }
    
    func editToDo(title: String?, descriprion: String?, date: Date?, color: UIColor, iconName: String) {
        interactor?.editTask(title: title, descriprion: descriprion, date: date , color: color, iconName: iconName)
    }
    
    func whantDeleteToDo() {
        guard let view = view else { return }
        router?.showAllert(with: view, status: .delete)
    }
}

extension ToDosDetailPresenter: ToDosDetailInteractorOutputProtocol {
    func showAllert(with status: ToDoDetailStatus) {
        guard let view = view else { return }
        router?.showAllert(with: view, status: status)
    }
    
    func deleteToDo() {
        interactor?.deleteTask()
    }
    
    func didDeleteToDo() {
        guard let view = view else { return }
        router?.goBackToTasks(with: view)
    }
}
