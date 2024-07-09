//
//  OptionsPresenter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 03.07.2024.
//

import UIKit

final class OptionsPresenter: OptionsPresenterProtocol {

    weak var view: OptionsViewProtocol?
    var interactor: OptionsInputInteractorProtocol?
    var router: OptionsRouterProtocol?
    
    func getData() {
        interactor?.fetchUserData()
        interactor?.fetchOptionsData()
    }
    
    func goToUserOptions() {
        guard let view = view else { return }
        router?.goToUserOptions(from: view)
    }
    
    func logOut() {
        guard let view = view else { return }
        interactor?.loggedOut()
        router?.logOut(from: view)
    }
    
    func getFeedback() {
        guard let view = view else { return }
        router?.getFeedback(from: view)
    }
    
    func changeTheme(_ bool: Bool) {
        interactor?.changeTheme(bool)
    }
    
    func updateUserData() {
        interactor?.fetchUserData()
    }
}

extension OptionsPresenter: OptionsOutputInteractorProtocol {
    func getOptionsData(_ data: [String]) {
        view?.getOptionsData(data)
    }
    
    func getUserData(_ userData: (String, URL?)) {
        view?.getUserData(userData)
    }
}
