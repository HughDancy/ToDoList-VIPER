//
//  LoginPresenter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 26.01.2024.
//

import Foundation

final class LoginPresenter: LoginPresenterProtocol {
    weak var view: LoginViewProtocol?
    var interactor: LoginInteractorInputProtocol?
    var router: LoginRouterProtocol?
    
    func chekTheLogin(login: String, password: String) {
        interactor?.checkAutorizationData(login: login, password: password)
    }
}


