//
//  MockToDosPresenter.swift
//  ToDoList-VIPERTests
//
//  Created by Борис Киселев on 02.08.2024.
//

import UIKit
@testable import ToDoList_VIPER

class MockToDosPresenter: ToDosPresenterProtocol {
    var taskIsRerive = false

    weak var view: ToDoList_VIPER.ToDosViewProtocol?
    var interactor: ToDoList_VIPER.ToDosInteractorInputProtocol?
    var router: ToDoList_VIPER.ToDosRouterProtocol?
    var status: ToDoList_VIPER.ToDoListStatus?
    
    func getToDos() {
        guard let statusDate = status else { return }
        interactor?.fetchFirstTasks(statusDate)
    }
    
    func fetchToDos(date: Date) {
        guard let status = self.status else { return }
        interactor?.fetchTask(date: date, status: status)
    }
    
    func updateToDosForDay(_ date: Date) {
        guard let status = self.status else { return }
        interactor?.fetchTask(date: date, status: status)
    }
    
    func doneToDo(_ taskId: UUID) { }
    func deleteToDo(_ taskId: UUID) { }
    func goToTask(_ task: ToDoList_VIPER.ToDoObject) { }

}

extension MockToDosPresenter: ToDosInteractorOutputProtocol {
    func getTask(_ tasks: [ToDoList_VIPER.ToDoObject]) {
        self.taskIsRerive = true
    }
}
