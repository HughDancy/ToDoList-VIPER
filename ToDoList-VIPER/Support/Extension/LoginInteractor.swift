//
//  LoginInteractor.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 26.01.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import GoogleSignIn
import GoogleSignInSwift

final class LoginInteractor: LoginInteractorInputProtocol {
    var presenter: LoginInteractorOutputProtocol?
    //MARK: - Properties
    private var keyChainedManager = AuthKeychainManager()
    private let db = Firestore.firestore()
    
    //MARK: - Login with email and password
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
    
    //MARK: - Google SignIn
    func googleLogIn(with: LoginViewProtocol) {
        guard let viewController = with as? UIViewController else { return }
        GIDSignIn.sharedInstance.signIn(withPresenting: viewController) { signInResult, error in
            guard error == nil else {
                print("some auth error in googleLogin method")
                self.presenter?.getVerificationResult(with: .wrongEnteredData)
                return
            }
            
            let uuid = signInResult?.user.userID ?? UUID().uuidString
            let userName = signInResult?.user.profile?.name
            self.writeUserDataGoogleSingIn(signInResult: signInResult, userName: userName, uuid: uuid)
        }
    }
    
    func changeOnboardingState() {
        NewUserCheck.shared.setIsLoginScrren()
    }
}

   //MARK: - SingIn with email and password method
extension LoginInteractor {
    private func logInWithEmailAndPassword(email: String, password: String) {
        let taskManager = FirebaseStorageManager()
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] dataResult, error in
            if error != nil {
                self?.presenter?.getVerificationResult(with: .wrongEnteredData)
            } else {
                Task {
                    await taskManager.loadTaskFromFirestore()
                    taskManager.chekOverdueTasks()
                }
                let uid = dataResult?.user.uid ?? UUID().uuidString
                let name = Auth.auth().currentUser?.displayName
                UserDefaults.standard.set(name, forKey: NotificationNames.userName.rawValue)
                self?.keyChainedManager.persist(id: uid)
                self?.presenter?.getVerificationResult(with: .success)
            }
        }
    }
}
    //MARK: - Google SingIn Method extension
extension LoginInteractor {
    private func writeUserDataGoogleSingIn(signInResult: GIDSignInResult?, userName: String?, uuid: String) {
        let docRef = db.collection("users").whereField("uid", isEqualTo: uuid)
        docRef.getDocuments { snapshot, error in
            if error != nil {
                print(error?.localizedDescription as Any)
            } else {
                if let doc = snapshot?.documents, !doc.isEmpty {
                    NotificationCenter.default.post(name: NotificationNames.googleSignIn.name, object: nil)
                    self.setUserName(userName)
                    self.keyChainedManager.persist(id: uuid)
                    self.presenter?.getVerificationResult(with: .googleSignInSucces)
                } else {
                    let newUserName = signInResult?.user.profile?.name ?? "Some User"
                    self.db.collection("users").document(uuid).setData( [
                        "email" : signInResult?.user.profile?.email ?? "",
                        "name" : signInResult?.user.profile?.name ?? "",
                        "password" : "",
                        "uid": uuid
                    ], completion: { error in
                        if error != nil {
                            self.presenter?.getVerificationResult(with: .wrongEnteredData)
                        } else {
                            self.saveGoogleUserData(name: newUserName, uid: uuid)
                        }})
                }
            }
        }
    }
    
    private func saveGoogleUserData(name: String, uid: String) {
        let taskManager = FirebaseStorageManager()
        DispatchQueue.main.async {
            let image = UIImage(named: "mockUser_3")!
            taskManager.saveImage(image: image, name: uid)
        }
        self.keyChainedManager.persist(id: uid)
        NotificationCenter.default.post(name: NotificationNames.googleSignIn.name, object: nil)
        self.setUserName(name)
        Task {
            await taskManager.loadTaskFromFirestore()
            taskManager.chekOverdueTasks()
        }
        self.presenter?.getVerificationResult(with: .googleSignInSucces)
    }
}

   //MARK: - Get user name method
extension LoginInteractor {
    private func setUserName(_ name: String?) {
        guard let userName = name else {
            UserDefaults.standard.setValue("Test", forKeyPath: "UserName")
            return
        }
        UserDefaults.standard.setValue(userName, forKeyPath: "UserName")
    }
}
