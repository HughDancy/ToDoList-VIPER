//
//  ForgettPasswordInteractor.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 07.06.2024.
//

import Foundation
import FirebaseAuth

final class ForgettPasswordInteractor: ForgettPasswordInreractorInputProtocol {
    weak var presenter: ForgettPasswordInreractorOutputProtocol?

    func resetPassword(with email: String) {
        if  email == "" || email.isValidEmail() == false {
            presenter?.returnResult(with: .failure)
        }

        if Reachability.isConnectedToNetwork() {
            Auth.auth().sendPasswordReset(withEmail: email, completion: { (error) in
                if error == nil {
                    self.presenter?.returnResult(with: .wellDone)
                } else {
                    self.presenter?.returnResult(with: .failure)
                }
            })
        } else {
            presenter?.returnResult(with: .networkError)
        }
    }
}
