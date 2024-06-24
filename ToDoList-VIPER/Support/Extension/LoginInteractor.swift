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
    private let firebaseStorage = FirebaseStorageManager.shared
    private let taskManager = FirebaseStorageManager()
    
    //MARK: - Login
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
                    let uid = dataResult?.user.uid ?? UUID().uuidString
                    let name = Auth.auth().currentUser?.displayName
                    UserDefaults.standard.set(name, forKey: NotificationNames.userName.rawValue)
                    self.keyChainedManager.persist(id: uid)
                    Task {
                        await self.taskManager.loadTaskFromFirestore()
                    }
                    self.presenter?.getVerificationResult(with: .success)
                }
            }
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
            var userName = signInResult?.user.profile?.name
            let docRef = self.db.collection("users").whereField("uid", isEqualTo: uuid)
            
            docRef.getDocuments { snapshot, error in
                if error != nil {
                    print(error?.localizedDescription as Any)
        
                } else {
                    if let doc = snapshot?.documents, !doc.isEmpty {
                        NotificationCenter.default.post(name: NotificationNames.googleSignIn.name, object: nil)
                        self.setUserName(userName)
                        self.presenter?.getVerificationResult(with: .googleSignInSucces)
                        print("Seems all is alright")
                    } else {
                        userName = signInResult?.user.profile?.name
                        self.db.collection("users").addDocument(data: [
                            "email" : signInResult?.user.profile?.email ?? "",
                            "name" : signInResult?.user.profile?.name ?? "",
                            "password" : "",
                            "uid": uuid
                        ], completion: { error in
                            if error != nil {
                                self.presenter?.getVerificationResult(with: .wrongEnteredData)
                            } else {
                                DispatchQueue.main.async {
                                    let image = UIImage(named: "mockUser_3")!
                                    self.firebaseStorage.saveImage(image: image, name: uuid)
                                }
                                self.keyChainedManager.persist(id: uuid)
                                NotificationCenter.default.post(name: NotificationNames.googleSignIn.name, object: nil)
                                self.setUserName(userName)
                                Task {
                                    await self.taskManager.loadTaskFromFirestore()
                                }
                                self.presenter?.getVerificationResult(with: .googleSignInSucces)
                            }})
                    }
                }
            }
        }
    }
    
    func changeOnboardingState() {
        NewUserCheck.shared.setIsLoginScrren()
    }
    
    //MARK: - Get user name
    private func setUserName(_ name: String?) {
        guard let userName = name else {
            UserDefaults.standard.setValue("Test", forKeyPath: "UserName")
            return
        }
        UserDefaults.standard.setValue(userName, forKeyPath: "UserName")
    }
}

