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
    
    func goBack() {
        guard let view = view else { return }
        router?.navigateBackToListViewController(from: view)
    }
}


