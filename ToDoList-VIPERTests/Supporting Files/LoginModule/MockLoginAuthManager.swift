//
//  MockLoginAuthManager.swift
//  ToDoList-VIPERTests
//
//  Created by Борис Киселев on 08.08.2024.
//

import UIKit.UIViewController
@testable import ToDoList_VIPER

final class MockLoginAuthManager: LoginProtocol {
    func signIn(email: String, password: String, compelitionHandler: @escaping (ToDoList_VIPER.LogInStatus) -> Void) {
        if email == "user@mail.ru" && password == "1234" {
            compelitionHandler(.success)
        } else {
            compelitionHandler(.wrongEnteredData)
        }
    }
    
    func googleSignIn(viewController: UIViewController, compelitionHadler: @escaping (ToDoList_VIPER.LogInStatus, String?) -> Void) {
        compelitionHadler(.googleSignInSucces, UUID().uuidString)
    }
    

}
