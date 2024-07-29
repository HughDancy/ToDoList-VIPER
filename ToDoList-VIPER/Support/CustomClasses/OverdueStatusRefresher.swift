//
//  OverdueStatusRefresher.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 24.07.2024.
//

import Foundation

final class OverdueStatusRefresher {
    static let shared = OverdueStatusRefresher()
    private let defaults = UserDefaults.standard
    private let defaultsKey = "lastOverdueRefresh"
    private let calender = Calendar.current

    func loadDataIfNeeded(completion: (Bool) -> Void) {

        if isRefreshRequired() {
            defaults.set(Date.today, forKey: defaultsKey)
            print("Refresher is change data")
            completion(true)
        } else {
            print("Refresher not change data")
            completion(false)
        }
    }

    private func isRefreshRequired() -> Bool {

        guard let lastRefreshDate = defaults.object(forKey: defaultsKey) as? Date else {
            return true
        }

        if let diff = calender.dateComponents([.hour], from: lastRefreshDate, to: Date()).hour, diff > 24 {
            return true
        } else {
            return false
        }
    }
}
