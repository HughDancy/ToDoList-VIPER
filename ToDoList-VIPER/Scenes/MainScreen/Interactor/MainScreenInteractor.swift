//
//  MainScreenInteractor.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 15.03.2024.
//

import Foundation
import FirebaseFirestore

final class MainScreenInteractor: MainScreenInteractorInputProtocol {
    var presenter: MainScreenInteractorOutputProtocol?
    private var storage = TaskStorageManager.instance
    
    func retriveUserData() {
        let imageUrl = UserDefaults.standard.url(forKey: "UserAvatar")
//        print("Main Screen Interactor image url us - \(imageUrl)")
        guard let name = UserDefaults.standard.string(forKey: NotificationNames.userName.rawValue) else {
            presenter?.didRetriveUserData(( "User", imageUrl))
            return
        }
        print("USER NAME IN USER DEFAULTS - \(name)")
            presenter?.didRetriveUserData((name, imageUrl))
    }
    
    func getToDosCount() {
            let todayToDosCount = self.storage.fetchToDosCount(with: .today)
            let tommorowToDosCount = self.storage.fetchToDosCount(with: .tommorow)
            let overdueToDosCount = self.storage.fetchToDosCount(with: .overdue)
            let doneToDosCount =  self.storage.fetchToDosCount(with: .done)
            let allToDos = self.storage.fetchAllPrivateToDos()
//        print("It's all toDos count -\(allToDos)")
            
            let toDosInfo = [
                [String(todayToDosCount), "Сегодня"],
                [String(overdueToDosCount), "Просрочено"],
                [String(tommorowToDosCount), "Завтра"],
                [String(doneToDosCount), "Завершено"]
            ]
            self.presenter?.didRetriveToDosCount(toDosInfo)
    }
}
