//
//  MockToDosDetailPresenter.swift
//  ToDoList-VIPERTests
//
//  Created by Борис Киселев on 02.08.2024.
//

import UIKit
@testable import ToDoList_VIPER

class MockToDosDetailPresenter: ToDosDetailPresenterProtocol {
    // MARK: - Test Props
    var status: ToDoList_VIPER.ToDoDetailStatus? = nil
    var deleteIsSucces = false
    var succes = false
    
    // MARK: - Protocol Props
    weak var view: ToDoList_VIPER.ToDosDetailViewProtocol?
    var interactor: ToDoList_VIPER.ToDosDetailInteractorInputProtocol?
    var router: ToDoList_VIPER.ToDosDetailRouterProtocol?
    
    func getToDo() {
        guard let task = interactor?.toDoItem else { return }
        view?.showToDoItem(task)
    }
    
    func editToDo(title: String?, descriprion: String?, date: Date?, color: UIColor, iconName: String) {
        interactor?.editTask(title: title, descriprion: descriprion, date: date, color: color, iconName: iconName)
    }
    
    func whantDeleteToDo() {
        guard let view = view else { return }
        router?.showAllert(with: view, status: .delete)
    }
}

extension MockToDosDetailPresenter: ToDosDetailInteractorOutputProtocol {
    func deleteToDo() {
        self.deleteIsSucces = true
    }
    
    func didDeleteToDo() {
        self.succes = true
    }
    
    func showAllert(with status: ToDoList_VIPER.ToDoDetailStatus) {
        guard let view = view else { return }
        self.router?.showAllert(with: view, status: status)
        
        switch status {
        case .allSave:
            self.status = .allSave
        case .delete:
            self.status = .delete
        case .error:
            self.status = .error
        }
    }
}
