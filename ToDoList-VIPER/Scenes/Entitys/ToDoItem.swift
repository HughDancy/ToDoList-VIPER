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
    
    init(title: String, content: String) {
        self.title = title
        self.content = content
    }
}
