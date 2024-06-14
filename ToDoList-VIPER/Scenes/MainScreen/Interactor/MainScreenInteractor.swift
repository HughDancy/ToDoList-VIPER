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
    private var firebaseStorage = FirebaseStorageManager.shared
    
    func retriveUserData() {
        let imageUrl = firebaseStorage.loadAvatar()
        guard let name = UserDefaults.standard.string(forKey: NotificationNames.userName.rawValue) else {
            presenter?.didRetriveUserData(( "User", imageUrl))
            return
        }
            presenter?.didRetriveUserData((name, imageUrl))
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
