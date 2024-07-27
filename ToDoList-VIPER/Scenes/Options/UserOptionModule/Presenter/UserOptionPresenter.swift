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
    
    deinit {
           debugPrint("? deinit \(self)")
       }
    
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
        router?.showImageSourceAlert(from: view)
    }
    
    func saveUserInfo(name: String) {
        interactor?.saveUserInfo(name: name)
    }
    
    func setImage(_ image: UIImage?) {
        interactor?.setTempAvatar(image)
    }
    
    func checkPermission(with status: PermissionStatus) {
        interactor?.checkPermission(with: status)
    }
}

extension UserOptionPresenter: UserOptionOutputInteractorProtocol {
    func goToOptions(with label: String) {
        guard let view = view else { return }
        router?.goToOption(from: view, with: label)
    }
    
    func goToImagePicker(with status: PermissionStatus) {
        guard let view = view else { return }
        router?.goToImagePicker(from: view, status: status)
    }
    
    func loadUserData(_ data: (String, URL?)) {
        view?.getUserData(data)
    }
    
    func dismiss() {
        guard let view = view else { return }
        router?.goBack(from: view)
    }
}
