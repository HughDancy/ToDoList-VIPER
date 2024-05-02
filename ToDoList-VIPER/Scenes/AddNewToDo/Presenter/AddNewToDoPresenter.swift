//
//  AddNewPresenter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 18.03.2024.
//

import UIKit

final class AddNewToDoPresenter: AddNewToDoPresenterProtocol {
    weak var view:  AddNewToDoViewProtocol?
    var interactor: AddNewToDoInteractorProtocol?
    var router: AddNewToDoRouterProtocol?
    
    func addNewToDo(with name: String?, description: String?, date: Date?, colorCathegory: UIColor) {
        interactor?.addNewToDo(with: name, description: description, date: date, colorCathegory: colorCathegory)
    }
    
    func goBackToMain() {
        guard let view = view else { return }
        router?.dismiss(from: view)
    }
    
    func showAlert() {
        guard let view = view else { return }
        router?.showAlert(from: view)
    }
}
