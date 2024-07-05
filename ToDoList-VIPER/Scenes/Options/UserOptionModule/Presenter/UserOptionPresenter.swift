//
//  UserOptionPresenter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 05.07.2024.
//

import UIKit

final class UserOptionPresenter: UserOptionPresenterProtocol {
   //MARK: - Properties
    weak var view: UserOptionViewProtocol?
    var interactor: UserOptionInputInteractorProtocol?
    var router: UserOptionRouterProtocol?
    
   //MARK: - Protocols Method's
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
    
    func saveUserInfo(name: String) {
        interactor?.saveUserInfo(name: name)
    }
    
    func setImage(_ image: UIImage?) {
        interactor?.setTempAvatar(image)
    }
    
}

extension UserOptionPresenter: UserOptionOutputInteractorProtocol {
    func loadUserData(_ data: (String, URL?)) {
        view?.getUserData(data)
    }
}
