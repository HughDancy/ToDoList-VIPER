//
//  LoginInteractor.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 26.01.2024.
//

import Foundation
import FirebaseAuth

final class LoginInteractor: LoginInteractorInputProtocol {
    var presenter: LoginInteractorOutputProtocol?
    
    
    func checkAutorizationData(login: String, password: String) {
        Auth.auth().signIn(withEmail: login, password: password) { dataResult, error in
            if error != nil {
                self.presenter?.getVerificationResult(with: false)
            } else {
                self.presenter?.getVerificationResult(with: true)
            }
        }
    }
    
    func changeOnboardingState() {
        NewUserCheck.shared.setIsLoginScrren()
    }
}
