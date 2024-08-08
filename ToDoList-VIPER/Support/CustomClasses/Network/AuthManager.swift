//
//  AuthManager.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 07.08.2024.
//

import FirebaseAuth
import FirebaseFirestore
import GoogleSignIn
import GoogleSignInSwift

protocol LoginProtocol: AnyObject {
    var result: Bool { get set }
    func signIn(email: String, password: String, compelitionHandler: @escaping (LogInStatus) -> Void)
    func googleSignIn(viewController: UIViewController, compelitionHadler: @escaping (LogInStatus) -> Void)
}

final class AuthManager: LoginProtocol {
    private let keyChainedManager = AuthKeychainManager()
    var result: Bool = false

    func signIn(email: String, password: String, compelitionHandler: @escaping (LogInStatus) -> Void) {
        let keychainManager = AuthKeychainManager()
        Auth.auth().signIn(withEmail: email, password: password) { dataResult, error in
            if error != nil {
                compelitionHandler(.wrongEnteredData)
            } else {
                let uid = dataResult?.user.uid ?? UUID().uuidString
                let name = Auth.auth().currentUser?.displayName
                UserDefaults.standard.set(name, forKey: UserDefaultsNames.userName.name)
                keychainManager.persist(id: uid)
                compelitionHandler(.success)
            }
        }
    }

    func googleSignIn(viewController: UIViewController, compelitionHadler: @escaping (LogInStatus) -> Void) {
        GIDSignIn.sharedInstance.signIn(withPresenting: viewController) { signInResult, error in
            guard error == nil else {
                print("some auth error in googleLogin method")
                compelitionHadler(.wrongEnteredData)
                return
            }
            let uuid = signInResult?.user.userID ?? UUID().uuidString
            let userName = signInResult?.user.profile?.name
            self.writeUserDataGoogleSingIn(signInResult: signInResult, userName: userName, uuid: uuid, viewController: viewController)
            compelitionHadler(.googleSignInSucces)
        }
    }
}
  // MARK: - Saving Google-SingIn Users Info into server and device storage
extension AuthManager {
    private func writeUserDataGoogleSingIn(signInResult: GIDSignInResult?, userName: String?, uuid: String, viewController: UIViewController) {
        let firebaseDataBase = Firestore.firestore()
        let docRef = firebaseDataBase.collection("users").whereField("uid", isEqualTo: uuid)
        docRef.getDocuments { snapshot, error in
            if error != nil {
                print(error?.localizedDescription as Any)
            } else {
                if let doc = snapshot?.documents, !doc.isEmpty {
                    NotificationCenter.default.post(name: NotificationNames.googleSignIn.name, object: nil)
                    self.setUserName(userName)
                    self.keyChainedManager.persist(id: uuid)
                    NotificationCenter.default.post(name: NotificationNames.updateUserData.name, object: nil)
                } else {
                    let newUserName = signInResult?.user.profile?.name ?? "Some User"
                    firebaseDataBase.collection("users").document(uuid).setData( [
                        "email" : signInResult?.user.profile?.email ?? "",
                        "name" : signInResult?.user.profile?.name ?? "",
                        "password" : "",
                        "uid": uuid
                    ], completion: { error in
                        if error != nil {
                            print(error?.localizedDescription as Any)
                        } else {
                            self.keyChainedManager.persist(id: uuid)
                            self.setUserName(newUserName)
                            NotificationCenter.default.post(name: NotificationNames.googleSignIn.name, object: nil)
                            NotificationCenter.default.post(name: NotificationNames.updateUserData.name, object: nil)
                        }})
                }
            }
        }
    }

    private func setUserName(_ name: String?) {
        guard let userName = name else {
            UserDefaults.standard.set("Test", forKey: UserDefaultsNames.userName.name)
            return
        }
        UserDefaults.standard.set(userName, forKey: UserDefaultsNames.userName.name)
    }

    private func saveBaseUserInfo(name: String, uid: String) {
        self.keyChainedManager.persist(id: uid)
        NotificationCenter.default.post(name: NotificationNames.googleSignIn.name, object: nil)
        self.setUserName(name)
    }
}
