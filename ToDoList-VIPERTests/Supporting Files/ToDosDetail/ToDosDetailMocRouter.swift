//
//  ToDosDetailMocRouter.swift
//  ToDoList-VIPERTests
//
//  Created by Борис Киселев on 03.08.2024.
//

import UIKit
@testable import ToDoList_VIPER

class ToDosDetailMocRouter: ToDosDetailRouterProtocol {
    var presenter:  ToDoList_VIPER.ToDosDetailInteractorOutputProtocol?
    
    func showAllert(with view: any ToDoList_VIPER.ToDosDetailViewProtocol, status: ToDoList_VIPER.ToDoDetailStatus) {
        switch status {

        case .allSave:
            self.presenter?.didDeleteToDo()
        case .delete:
            self.presenter?.deleteToDo()
        case .error:
            self.presenter?.didDeleteToDo()
        }
    }
    
    func goBackToTasks(with view: any ToDoList_VIPER.ToDosDetailViewProtocol) {
        
    }
}
