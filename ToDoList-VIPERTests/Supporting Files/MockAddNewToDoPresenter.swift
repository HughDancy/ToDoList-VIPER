//
//  MockAddNewToDoPresenter.swift
//  ToDoList-VIPERTests
//
//  Created by Борис Киселев on 02.08.2024.
//

import UIKit
@testable import ToDoList_VIPER

class MockAddNewToDoPresenter: AddNewToDoPresenterProtocol {
    // MARK: - Test props
    var succes = false
    var error = false
    // MARK: - Protocol props
    weak var view:  ToDoList_VIPER.AddNewToDoViewProtocol?
    var interactor:  ToDoList_VIPER.AddNewToDoInteractorProtocol?
    var router:  ToDoList_VIPER.AddNewToDoRouterProtocol?
    
    func addNewToDo(with name: String?, description: String?, date: Date?, colorCategory: UIColor, iconName: String) {
        interactor?.addNewToDo(with: name, description: description, date: date, colorCategory: colorCategory, iconName: iconName)
    }
    
    func goBackToMain() {
        self.succes = true
    }
    
    func showAlert() {
        self.error = true
    }
}


