//
//  AddNewPresenter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 18.03.2024.
//

import UIKit

final class AddNewPresenter: AddNewToDoPresenterProtocol {
    weak var view:  AddNewToDoViewProtocol?
    var interactor: AddNewToDoInteractorProtocol?
    var router: AddNewToDoRouterProtocol?
    
    func addNewToDo(with name: String, description: String, date: Date, mark: String) {
        interactor?.addNewToDo(with: name, description: description, date: date, mark: mark)
    }
    
    func goBackToMain(from view: AddNewToDoViewProtocol) {
//        guard let parrentView = view else { return }
        router?.dismiss(from: view)
    }
}
