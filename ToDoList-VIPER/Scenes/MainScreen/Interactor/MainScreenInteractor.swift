//
//  MainScreenInteractor.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 15.03.2024.
//

import Foundation
import FirebaseFirestore

final class MainScreenInteractor: MainScreenInteractorInputProtocol {
    weak var presenter: MainScreenInteractorOutputProtocol?
    private var storage = TaskStorageManager.instance
    private var firebaseStorageManager = FirebaseStorageManager()

    func retriveUserData() {
        firebaseStorageManager.newLoadAvatar { [weak self] imageUrl in
            let newImageUrl = imageUrl
            self?.presenter?.didRetriveUserAvatar(newImageUrl)
        }

        guard let name = UserDefaults.standard.string(forKey: NotificationNames.userName.rawValue) else {
            self.presenter?.didRetriveUserName("Test User")
            return
        }
        self.presenter?.didRetriveUserName(name)
    }

    func getToDosCount() {
            let todayToDosCount = self.storage.fetchToDosCount(with: .today)
            let tommorowToDosCount = self.storage.fetchToDosCount(with: .tommorow)
            let overdueToDosCount = self.storage.fetchToDosCount(with: .overdue)
            let doneToDosCount =  self.storage.fetchToDosCount(with: .done)

            let toDosInfo = [
                [String(todayToDosCount), "Сегодня"],
                [String(overdueToDosCount), "Просрочено"],
                [String(tommorowToDosCount), "Завтра"],
                [String(doneToDosCount), "Завершено"]
            ]
            self.presenter?.didRetriveToDosCount(toDosInfo)
    }
}
