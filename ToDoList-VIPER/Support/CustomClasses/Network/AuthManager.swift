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
    func signIn(email: String, password: String, compelitionHandler: @escaping (LogInStatus) -> Void)
    func googleSignIn(viewController: UIViewController, compelitionHadler: @escaping (LogInStatus, String?) -> Void)
}

protocol RegistrationProtocol: AnyObject {
    func registerUser(name: String, email: String, password: String, compelition: @escaping(RegistrationStatus, String?) -> Void)
}

protocol ForgottPasswordProtocol: AnyObject {
    func resetPassword(email: String, compelition: @escaping (ResetStatus) -> Void)
}

// MARK: - Login Method's
final class AuthManager: LoginProtocol {
    private let keyChainedManager = AuthKeychainManager()

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

    func googleSignIn(viewController: UIViewController, compelitionHadler: @escaping (LogInStatus, String?) -> Void) {
        GIDSignIn.sharedInstance.signIn(withPresenting: viewController) { signInResult, error in
            guard error == nil else {
                print("some auth error in googleLogin method")
                compelitionHadler(.wrongEnteredData, nil)
                return
            }
            let uuid = signInResult?.user.userID ?? UUID().uuidString
            let userName = signInResult?.user.profile?.name
            self.writeUserDataGoogleSingIn(signInResult: signInResult, userName: userName, uuid: uuid, viewController: viewController)
            compelitionHadler(.googleSignInSucces, uuid)
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
// MARK: - Support mehtod
    private func setUserName(_ name: String?) {
        guard let userName = name else {
            UserDefaults.standard.set("Test", forKey: UserDefaultsNames.userName.name)
            return
        }
        UserDefaults.standard.set(userName, forKey: UserDefaultsNames.userName.name)
    }
}

// MARK: - Registration Method's
extension AuthManager: RegistrationProtocol {
    func registerUser(name: String, email: String, password: String, compelition: @escaping (RegistrationStatus, String?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if error != nil {
                compelition(.error, nil)
                print(error?.localizedDescription as Any)
            } else {
                let uid = result!.user.uid
                self.addNewUserToServer(uid: uid, email: email, name: name, password: password)
                compelition(.complete, uid)
            }
        }
    }

    private func addNewUserToServer(uid: String, email: String, name: String, password: String) {
        let firebaseDataBase = Firestore.firestore()
        firebaseDataBase.collection("users").document(uid).setData([
            "email" : email,
            "name" : name,
            "password" : password,
            "uid": uid
        ]) { error in
            if error != nil {
                print("Error save new user in data base ")
            } else {
                let user = Auth.auth().currentUser
                if let user = user {
                    let changeRequest = user.createProfileChangeRequest()

                    changeRequest.displayName = name
                    changeRequest.commitChanges { error in
                        if error != nil {
                            // An error happened.
                        } else {
                            // Profile updated.
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Reset Password method
extension AuthManager: ForgottPasswordProtocol {
    func resetPassword(email: String, compelition: @escaping (ResetStatus) -> Void) {
        if Reachability.isConnectedToNetwork() {
            Auth.auth().sendPasswordReset(withEmail: email, completion: { (error) in
                if error == nil {
//                    self.presenter?.returnResult(with: .wellDone)
                    compelition(.wellDone)
                } else {
                    compelition(.failure)
//                    self.presenter?.returnResult(with: .failure)
                }})
        } else {
            compelition(.networkError)
//            presenter?.returnResult(with: .networkError)
        }
    }
}
