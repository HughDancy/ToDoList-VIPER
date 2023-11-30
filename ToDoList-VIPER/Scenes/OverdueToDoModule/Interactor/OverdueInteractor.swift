//
//  OverdueInteractor.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 29.11.2023.
//

import Foundation

final class OverdueInteractor: OverdueInteractorInputProtocol {
    weak var presenter: OverdueInteractorOutputProtocol?
    var storage = ToDoStorage.instance
    
    func retriveToDos() {
        var toDosForSend = [[ToDoObject]]()
        let allToDos = storage.fetchUsers().filter({ $0.doneStatus == false })
        let now = Calendar.current.dateComponents(in: .current, from: Date())
        let yesterday = DateComponents(year: now.year, month: now.month, day: now.day! - 1)
        let dayBeforeYesterday = DateComponents(year: now.year, month: now.month, day: now.day! - 2)
        let dateYesterday = Calendar.current.date(from: yesterday)!
        let dateDayBedoreYesterday = Calendar.current.date(from: dayBeforeYesterday)!
        let yesterdayTitle = DateFormatter.createMediumDate(from: dateYesterday)
        let dayBeforeYesterdayTitle = DateFormatter.createMediumDate(from: dateDayBedoreYesterday)
        let todayTitle = DateFormatter.createMediumDate(from: Date.today)
        
        let yesterdayToDos = allToDos.filter({ $0.dateTitle == yesterdayTitle })
                                     .sorted { $0.date?.compare($1.date ?? Date()) == .orderedAscending }
        let dayBeforeYesterdayToDos = allToDos.filter({ $0.dateTitle == dayBeforeYesterdayTitle })
                                              .sorted { $0.date?.compare($1.date ?? Date()) == .orderedAscending }
        let anotherOverdueToDos = allToDos.filter({ $0.dateTitle != yesterdayTitle && $0.dateTitle != dayBeforeYesterdayTitle && $0.date ?? Date() < Date.today && $0.date ?? Date() < Date.tomorrow})
                                           .sorted { $0.date?.compare($1.date ?? Date()) == .orderedAscending }
        toDosForSend.append(yesterdayToDos)
        toDosForSend.append(dayBeforeYesterdayToDos)
        toDosForSend.append(anotherOverdueToDos)
        print(toDosForSend)
        presenter?.didRetriveToDos(toDosForSend)
    }
    
    func deleteToDos(_ toDo: ToDoObject) {
        storage.deleteToDoObject(item: toDo)
        presenter?.didRemoveToDo()
    }
    
    func doneToDo(_ toDo: ToDoObject) {
        storage.doneToDo(item: toDo)
        presenter?.didRemoveToDo()
    }
    
    
}
