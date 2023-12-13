//
//  OptionsPresenter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 13.12.2023.
//

import Foundation

final class OptionsPresenter: OptionsPresenterProtocol {
    var view: OptionsViewProtocol?
    var interactor: OptionsInteractorProtcol?
    var router: OptionsRouterProtocol?
    
    func viewWillAppear() {
        interactor?.showOptionsItems()
    }
    
    func changeTheme(with: Bool) {
        interactor?.changeUserTheme(with: with)
    }
    
    func goToNotification() {
        guard let view = view  else { return }
        router?.goToNotifications(from: view)
    }
    
    func goToFeedback() {
        guard let view = view  else { return }
        router?.goToFeedback(from: view)
    }
    
    func goToUserOptions() {
        guard let view = view  else { return }
        router?.goToUserOptions(from: view)
    }
    
    
}
