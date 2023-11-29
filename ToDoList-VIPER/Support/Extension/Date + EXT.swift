//
//  Date + EXT.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 29.11.2023.
//

import Foundation

extension Date {
   static var tomorrow:  Date { return Date().dayAfter }
   static var today: Date {return Date()}
   var dayAfter: Date {
      return Calendar.current.date(byAdding: .day, value: 1, to: Date())!
   }
}

