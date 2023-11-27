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
    
    func addToDo(title: String, content: String, date: Date, done: Bool) {
        interactor?.saveToDo(title: title, content: content, date: date, done: done)
    }
    
    func goBack() {
        guard let view = view else { return }
        router?.navigateBackToListViewController(from: view)
    }
}

extension AddToDoPresenter: AddToDoInteractorOutputProtocol {
    func backToMain() {
        if let view = view {
            router?.navigateBackToListViewController(from: view)
        }
    }
    
    
}


