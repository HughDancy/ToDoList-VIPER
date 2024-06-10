//
//  LoginInteractor.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 26.01.2024.
//

import Foundation
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift

final class LoginInteractor: LoginInteractorInputProtocol {
    var presenter: LoginInteractorOutputProtocol?
    var keyChainedManager = AuthKeychainManager()
    
    func checkAutorizationData(login: String?, password: String?) {
        switch (login != nil) && (password != nil) {
        case (login == "") || (password == ""):
            if login == "" {
                presenter?.getVerificationResult(with: .emptyLogin)
            } else {
                presenter?.getVerificationResult(with: .emptyPassword)
            }
        case login?.isValidEmail() == false:
            self.presenter?.getVerificationResult(with: .notValidEmail)
        default:
            guard let nickname = login,
                  let pass = password else { return }
            Auth.auth().signIn(withEmail: nickname, password: pass) { dataResult, error in
                if error != nil {
                    self.presenter?.getVerificationResult(with: .wrongEnteredData)
                } else {
                    self.keyChainedManager.persist(id: dataResult?.user.uid ?? UUID().uuidString)
                    self.presenter?.getVerificationResult(with: .success)
                }
            }
        }
    }
    
    func googleLogIn(with: LoginViewProtocol) {
        guard let viewController = with as? UIViewController else { return }
        GIDSignIn.sharedInstance.signIn(withPresenting: viewController) { signInResult, error in
            guard error == nil else {
                print("some auth error in googleLogin method")
                self.presenter?.getVerificationResult(with: .wrongEnteredData)
                return
            }
            self.presenter?.getVerificationResult(with: .success)
        }
    }
    
    func changeOnboardingState() {
        NewUserCheck.shared.setIsLoginScrren()
    }
}
