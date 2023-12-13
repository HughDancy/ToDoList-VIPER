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
    
   
    func changeUserTheme(with: Bool) {
        print(with)
    }
    
    func showOptionsItems() {
        presenter?.showOptionsData(items: optionsData)
    }
}
