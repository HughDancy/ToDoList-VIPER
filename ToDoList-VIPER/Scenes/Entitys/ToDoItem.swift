//
//  ToDoItem.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 08.11.2023.
//

import Foundation

final class ToDoItem {
    var title: String
    var content: String
    var date: String
    
    init(title: String, content: String, date: String) {
        self.title = title
        self.content = content
        self.date = date
    }
}
