//
//  OptionsInteractor.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 13.12.2023.
//

import UIKit

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
        
        let allScenes = UIApplication.shared.connectedScenes
        for scene in allScenes {
            guard let windowScene = scene as? UIWindowScene else { continue }
            windowScene.windows.forEach({$0.overrideUserInterfaceStyle = ToDoUserDefaults.shares.theme.getUserInterfaceStyle()})
        }
    }
    
    func showOptionsItems() {
        presenter?.showOptionsData(items: optionsData)
    }
}
