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
    let db = Firestore.firestore()
    
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
    
    private func registerUser(name: String, email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if error != nil {
                self.presenter?.getRegistrationResult(result: .error)
                print(error?.localizedDescription as Any)
            } else {
                self.db.collection("users").addDocument(data: [
                    "email" : email,
                    "name" : name,
                    "password" : password,
                    "uid": result!.user.uid
                ]) { error in
                    if error != nil {
                        print("Error save new user in data base ")
                        self.presenter?.getRegistrationResult(result: .error)
                    } else {
                        self.presenter?.getRegistrationResult(result: .complete)
                    }
                }
            }
        }
    }
    
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
}
