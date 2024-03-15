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
        presenter?.didRetriveUserData(["Винеамин", "mockUserAvatar"])
    }
    
    func getToDosCount() {
        let allNotDoneToDos = storage.fetchUsers().filter { $0.doneStatus == false }
        let allDoneToDos = storage.fetchUsers().filter { $0.doneStatus == true}
        let upcomingToDos = ToDoObjectSorter.sortByStatus(object: allNotDoneToDos, and: .upcoming)
    
        let todayToDosCount = upcomingToDos[0].count
        let tommorowToDosCount = upcomingToDos[1].count
        let overdueToDosCount = ToDoObjectSorter.sortByStatus(object: allNotDoneToDos, and: .overdue).count
        let doneToDosCount = allDoneToDos.count
        
        let toDosInfo = [
            [String(todayToDosCount), "Запланировано на сегодня"],
            [String(tommorowToDosCount), "Просрочено"],
            [String(tommorowToDosCount), "Запланировано на завтра"],
            [String(doneToDosCount), "Завершено"]
        ]
        presenter?.didRetriveToDosCount(toDosInfo)
    }
}
