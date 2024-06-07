//
//  ForgettPasswordInteractor.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 07.06.2024.
//

import Foundation
import FirebaseAuth

final class ForgettPasswordInteractor: ForgettPasswordInreractorInputProtocol {
    var presenter: ForgettPasswordInreractorOutputProtocol?
    
    func resetPassword(with email: String) {
        if  email == "" || email.isValidEmail() == false {
            presenter?.returnFailure()
        }
        
        if Reachability.isConnectedToNetwork() {
            Auth.auth().sendPasswordReset(withEmail: email, completion: { (error) in
                if error == nil  {
                    self.presenter?.returnWelldone()
                } else {
                    self.presenter?.returnFailure()
                }
            })
        } else {
            presenter?.returnNetworkError()
        }
    }
}
