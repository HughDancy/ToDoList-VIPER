//
//  RegistrationInteractor.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 29.01.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import AVFoundation
import Photos

final class RegistrationInteractor: RegistrationInteractorInputProtocol {
    var presenter: RegistrationInteractorOutputProtocol?
    private let db = Firestore.firestore()
    private var storageManager = FirebaseStorageManager()
    var avatarTemp = UIImage()
    
    //MARK: - Register from presenter method
    func registerNewUser(name: String, email: String, password: String) {
        if Reachability.isConnectedToNetwork() {
            if name != "" || email != "" || password != "" {
                if email.isValidEmail() {
                    self.registerUser(name: name, email: email, password: password)
                } else {
                    self.presenter?.getRegistrationResult(result: .notValidEmail)
                }
            } else {
                self.presenter?.getRegistrationResult(result: .emptyFields)
            }
        } else {
            self.presenter?.getRegistrationResult(result: .connectionLost)
        }
    }
    
    //MARK: -  Support register method
    private func registerUser(name: String, email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if error != nil {
                self.presenter?.getRegistrationResult(result: .error)
                print(error?.localizedDescription as Any)
            } else {
                let uid = result!.user.uid
                self.storageManager.saveImage(image: self.avatarTemp, name: uid)
                print("Login give me that result - result!.user.uid")
                self.addNewUserToServer(uid: uid, email: email, name: name, password: password)
            }
        }
    }
    
    //MARK: - Check permisson for avatar
    func checkPermission(with status: PermissionStatus) {
        switch status {
        case .camera:
            let cameraStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
            switch cameraStatus {
            case .authorized:
                presenter?.goToImagePicker(with: .camera)
                return
            case .denied:
                presenter?.goToOptions(with: "камере")
            case .notDetermined:
                AVCaptureDevice.requestAccess(for: AVMediaType.video) { (authorized) in
                    if (!authorized) {
                        abort()
                    }
                }
            case .restricted:
                abort()
            @unknown default:
                fatalError()
            }
        case .gallery:
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                switch status {
                case .authorized:
                    self.presenter?.goToImagePicker(with: .gallery)
                    print("Authorized")
                case .denied:
                    self.presenter?.goToOptions(with: "медиа библиотеке")
                case .limited:
                    print("Limited")
                case .notDetermined:
                    print("not determintd")
                case .restricted:
                    print("restricted")
                @unknown default:
                    fatalError()
                }
            }
        }
    }
    
    //MARK: - Set temp avatar for upload to server
    func setTempAvatar(_ image: UIImage) {
        self.avatarTemp = image
    }
}
    //MARK: - Register new user support method and write his data to server
fileprivate extension RegistrationInteractor {
    private func addNewUserToServer(uid: String, email: String, name: String, password: String) {
        self.db.collection("users").document(uid).setData([
            "email" : email,
            "name" : name,
            "password" : password,
            "uid": uid
        ])    { error in
            if error != nil {
                print("Error save new user in data base ")
                self.presenter?.getRegistrationResult(result: .error)
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
                self.presenter?.getRegistrationResult(result: .complete)
            }
        }
    }
}
