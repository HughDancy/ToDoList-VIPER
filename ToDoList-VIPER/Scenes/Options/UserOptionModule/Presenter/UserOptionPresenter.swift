//
//  UserOptionPresenter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 05.07.2024.
//

import UIKit

final class UserOptionPresenter: UserOptionPresenterProtocol {
    weak var view: UserOptionViewProtocol?
    var interactor: UserOptionInputInteractorProtocol?
    var router: UserOptionRouterProtocol?
    
    func retriveData() {
        interactor?.getUserInfo()
    }
    
    func goBack() {
        guard let view = view else { return }
        router?.goBack(from: view)
    }
    
    func chooseAvatar() {
        guard let view = view else { return }
        router?.chooseAvatarSource(from: view)
    }
    
    func saveUserInfo() {
        interactor?.saveUserInfo()
    }
}

extension UserOptionPresenter: UserOptionOutputInteractorProtocol {
    func loadUserData(_ data: (String, URL?)) {
        view?.getUserData(data)
    }
}
