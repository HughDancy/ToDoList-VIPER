//
//  MainScreenInteractor.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 15.03.2024.
//

import Foundation

final class MainScreenInteractor: MainScreenInteractorInputProtocol {
    var presenter: MainScreenInteractorOutputProtocol?
    private var storage = ToDoStorage.instance
    
    func retriveUserData() {
        presenter?.didRetriveUserData(["Женя", "mockUserAvatar"])
    }
    
    func getToDosCount() {
        let todayToDosCount = storage.fetchToDosCount(with: .today)
        let tommorowToDosCount = storage.fetchToDosCount(with: .tommorow)
        let overdueToDosCount = storage.fetchToDosCount(with: .overdue)
        let doneToDosCount = storage.fetchToDosCount(with: .done)
        
        let toDosInfo = [
            [String(todayToDosCount), "Сегодня"],
            [String(overdueToDosCount), "Просрочено"],
            [String(tommorowToDosCount), "Завтра"],
            [String(doneToDosCount), "Завершено"]
        ]
        presenter?.didRetriveToDosCount(toDosInfo)
    }
}
