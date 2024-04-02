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
        let allNotDoneToDos = storage.fetchToDos().filter { $0.doneStatus == false }
        let allDoneToDos = storage.fetchToDos().filter { $0.doneStatus == true}
        let upcomingToDos = ToDoObjectSorter.sortByStatus(object: allNotDoneToDos, and: .upcoming)
    
        let todayToDosCount = upcomingToDos[0].count
        let tommorowToDosCount = upcomingToDos[1].count
        let overdueToDos = ToDoObjectSorter.sortByStatus(object: allNotDoneToDos, and: .overdue)
        let overdueToDosCount = (overdueToDos[0].count) + (overdueToDos[1].count) + (overdueToDos[2].count)
        let doneToDosCount = allDoneToDos.count
        
        let toDosInfo = [
            [String(todayToDosCount), "Сегодня"],
            [String(overdueToDosCount), "Просрочено"],
            [String(tommorowToDosCount), "Завтра"],
            [String(doneToDosCount), "Завершено"]
        ]
        presenter?.didRetriveToDosCount(toDosInfo)
    }
}
