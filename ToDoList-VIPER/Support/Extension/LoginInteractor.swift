//
//  LoginInteractor.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 26.01.2024.
//

import Foundation
import GoogleSignIn
import GoogleSignInSwift

final class LoginInteractor: LoginInteractorInputProtocol {
    var presenter: LoginInteractorOutputProtocol?
    // MARK: - Properties
    var firebaseStorage: (LoginServerStorageProtocol & UserAvatarSaveInServerProtocol)?
    var authManager: LoginProtocol?

    // MARK: - Login with email and password
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
            self.logInWithEmailAndPassword(email: nickname, password: pass)
        }
    }

    // MARK: - Google SignIn
    func googleLogIn(with: LoginViewProtocol) {
        guard let viewController = with as? UIViewController else { return }
        self.authManager?.googleSignIn(viewController: viewController) { [weak self] status in
            switch status {
            case .googleSignInSucces:
                let uid = GIDSignIn.sharedInstance.currentUser?.userID ?? UUID.init().uuidString
                DispatchQueue.main.async {
                    let image = UIImage(named: "mockUser_3")!
                    self?.firebaseStorage?.checkAvatar(avatar: image, uid: uid)
                    self?.loadTaskFromServer()
                }
                self?.presenter?.getVerificationResult(with: .googleSignInSucces)
            case .wrongEnteredData:
                self?.presenter?.getVerificationResult(with: .wrongEnteredData)
            default:
                self?.presenter?.getVerificationResult(with: .wrongEnteredData)
            }
        }
    }

    func changeOnboardingState() {
        NewUserCheck.shared.setIsLoginScrren()
    }
}

// MARK: - SingIn with email and password method
extension LoginInteractor {
    private func logInWithEmailAndPassword(email: String, password: String) {
        self.authManager?.signIn(email: email, password: password) { [weak self] status in
            switch status {
            case .wrongEnteredData:
                self?.presenter?.getVerificationResult(with: .wrongEnteredData)
            case .success:
                self?.loadTaskFromServer()
                self?.presenter?.getVerificationResult(with: .success)
            default:
                self?.presenter?.getVerificationResult(with: .wrongEnteredData)
            }
        }
    }
}

extension LoginInteractor {
    private func loadTaskFromServer() {
        let taskManager = self.firebaseStorage
        Task {
            await taskManager?.loadTaskFromFirestore()
            taskManager?.chekOverdueToDos()
        }
    }
}
