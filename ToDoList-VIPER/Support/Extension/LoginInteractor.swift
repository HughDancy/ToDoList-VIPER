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
    private var keyChainedManager = AuthKeychainManager()
    private let db = Firestore.firestore()
    private let firebaseStorage = FirebaseStorageManager.shared
    
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
            
            let uuid = signInResult?.user.userID ?? UUID().uuidString
            print(uuid)
            let docRef = self.db.collection("users").whereField("uid", isEqualTo: uuid)
            
            docRef.getDocuments { snapshot, error in
                if error != nil {
                    print(error?.localizedDescription)
        
                } else {
                    if let doc = snapshot?.documents, !doc.isEmpty {
                        NotificationCenter.default.post(name: NotificationNames.googleSignIn.name, object: nil)
                        self.presenter?.getVerificationResult(with: .googleSignInSucces)
                        print("Seems all is alright")
                    } else {
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
}
