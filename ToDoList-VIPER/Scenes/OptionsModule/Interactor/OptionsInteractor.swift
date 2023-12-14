//
//  OptionsInteractor.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 13.12.2023.
//

import Foundation

final class OptionsInteractor: OptionsInteractorInputProtcol {
    var presenter: OptionsInteractorOutputProtocol?
    var optionsData = OptionsItems.options
    var toDoUserDefaults = ToDoUserDefaults.shares
    
   
    func changeUserTheme(with: Bool) {
        if with {
            toDoUserDefaults.theme = Theme(rawValue: "dark") ?? .dark
        } else {
            toDoUserDefaults.theme = Theme(rawValue: "light") ?? .light
        }
    }
    
    func showOptionsItems() {
        presenter?.showOptionsData(items: optionsData)
    }
}
