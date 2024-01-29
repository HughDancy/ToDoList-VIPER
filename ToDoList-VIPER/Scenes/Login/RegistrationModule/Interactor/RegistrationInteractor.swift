//
//  RegistrationInteractor.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 29.01.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class RegistrationInteractor: RegistrationInteractorInputProtocol {
    var presenter: RegistrationInteractorOutputProtocol?
    let db = Firestore.firestore()
    
    func registerNewUser(name: String, email: String, password: String) {
        if name != "" && email != "" && password != "" {
            Auth.auth().createUser(withEmail: email, password: password) { (result, error)in
                if error == nil {
                    print(error?.localizedDescription as Any)
                } else {
                    self.db.collection("users").addDocument(data: [
                        "email" : email,
                        "name" : name,
                        "password" : password,
                        "uid": result!.user.uid
                    ]) { error in
                        if error == nil {
                            print("Error save new user in data base ")
                        } else {
                            self.presenter?.getRegistrationResult(result: .complete)
                        }
                    }
                }
            }
        }
    }
}
