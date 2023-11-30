//
//  ToDoObjectSorter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 30.11.2023.
//

import Foundation

public enum ToDoType {
    case upcoming
    case overdue
    case completed
}

final class ToDoObjectSorter {
    
    static func sortByVoid(object: [[ToDoObject]]) -> Bool {
        if object[0].isEmpty && object[1].isEmpty && object[2].isEmpty {
            return true
        } else {
            return false
        }
    }
    
    static func sortByStatus(object: [ToDoObject], and toDoType: ToDoType) -> [[ToDoObject]] {
        let alltoDos = object.filter { $0.doneStatus == false }
        var outputMatrix = [[ToDoObject]]()
        
        switch toDoType {
        case .upcoming:
            let todoay = DateFormatter.createMediumDate(from: Date.today)
            let tommorow = DateFormatter.createMediumDate(from: Date.tomorrow)
       
            let toDayToDos = alltoDos.filter { $0.dateTitle == todoay }
            let tommorowToDos = alltoDos.filter { $0.dateTitle == tommorow }
            let anotherToDos = alltoDos.filter { $0.dateTitle != todoay && $0.dateTitle != tommorow && $0.date ?? Date() > Date.today}
            let sortedAnotherToDos = anotherToDos.sorted { $0.date?.compare($1.date ?? Date()) == .orderedAscending }
            outputMatrix.append(toDayToDos)
            outputMatrix.append(tommorowToDos)
            outputMatrix.append(sortedAnotherToDos)
            return outputMatrix
        case .overdue:
            let now = Calendar.current.dateComponents(in: .current, from: Date())
            let yesterday = DateComponents(year: now.year, month: now.month, day: now.day! - 1)
            let dayBeforeYesterday = DateComponents(year: now.year, month: now.month, day: now.day! - 2)
            let dateYesterday = Calendar.current.date(from: yesterday)!
            let dateDayBedoreYesterday = Calendar.current.date(from: dayBeforeYesterday)!
            let yesterdayTitle = DateFormatter.createMediumDate(from: dateYesterday)
            let dayBeforeYesterdayTitle = DateFormatter.createMediumDate(from: dateDayBedoreYesterday)
            
            let yesterdayToDos = alltoDos.filter({ $0.dateTitle == yesterdayTitle })
                                         .sorted { $0.date?.compare($1.date ?? Date()) == .orderedAscending }
            let dayBeforeYesterdayToDos = alltoDos.filter({ $0.dateTitle == dayBeforeYesterdayTitle })
                                                  .sorted { $0.date?.compare($1.date ?? Date()) == .orderedAscending }
            let anotherOverdueToDos = alltoDos.filter({ $0.dateTitle != yesterdayTitle &&
                                                                $0.dateTitle != dayBeforeYesterdayTitle &&
                                                                $0.date ?? Date() < Date.today && $0.date ?? Date() < Date.tomorrow})
                                               .sorted { $0.date?.compare($1.date ?? Date()) == .orderedAscending }
            outputMatrix.append(yesterdayToDos)
            outputMatrix.append(dayBeforeYesterdayToDos)
            outputMatrix.append(anotherOverdueToDos)
            return outputMatrix
        case .completed:
            let allToDo = object.filter { $0.doneStatus == true }
            let now = Calendar.current.dateComponents(in: .current, from: Date())
            let yesterday = DateComponents(year: now.year, month: now.month, day: now.day! - 1)
            let dayBeforeYesterday = DateComponents(year: now.year, month: now.month, day: now.day! - 2)
            let dateYesterday = Calendar.current.date(from: yesterday)!
            let dateDayBedoreYesterday = Calendar.current.date(from: dayBeforeYesterday)!
            let yesterdayTitle = DateFormatter.createMediumDate(from: dateYesterday)
            let dayBeforeYesterdayTitle = DateFormatter.createMediumDate(from: dateDayBedoreYesterday)
            
            let yesterdayToDos = allToDo.filter({ $0.dateTitle == yesterdayTitle })
                                         .sorted { $0.date?.compare($1.date ?? Date()) == .orderedAscending }
            let dayBeforeYesterdayToDos = allToDo.filter({ $0.dateTitle == dayBeforeYesterdayTitle })
                                                  .sorted { $0.date?.compare($1.date ?? Date()) == .orderedAscending }
            let anotherOverdueToDos = allToDo.filter({ $0.dateTitle != yesterdayTitle &&
                                                                $0.dateTitle != dayBeforeYesterdayTitle &&
                                                                $0.date ?? Date() < Date.today && $0.date ?? Date() < Date.tomorrow})
                                               .sorted { $0.date?.compare($1.date ?? Date()) == .orderedAscending }
            outputMatrix.append(yesterdayToDos)
            outputMatrix.append(dayBeforeYesterdayToDos)
            outputMatrix.append(anotherOverdueToDos)
            return outputMatrix
        }
    }
}
