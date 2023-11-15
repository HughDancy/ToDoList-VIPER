//
//  AddToDoPresenter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 15.11.2023.
//

import Foundation

final class AddToDoPresenter: AddToDoPresenterProtocol {
    weak var view: AddToDoViewProtocol?
    var interactor: AddToDoInteractorInputProtocol?
    var router: AddToDoRouterProtocol?
    
    func addToDo(_ toDoItem: ToDoItem) {
        interactor?.saveToDo(toDoItem)
    }
}

