//
//  RegistrationInteractor.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 29.01.2024.
//

import Foundation

final class RegistrationInteractor: RegistrationInteractorInputProtocol {
    var presenter: RegistrationInteractorOutputProtocol?
    
    func registerNewUser(name: String, email: String, password: String) {
        presenter?.getRegistrationResult(result: true)
    }
}
