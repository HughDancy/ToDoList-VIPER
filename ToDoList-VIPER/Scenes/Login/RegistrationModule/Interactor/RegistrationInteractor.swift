//
//  RegistrationInteractor.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 29.01.2024.
//

import UIKit.UIImage
import AVFoundation
import Photos

final class RegistrationInteractor: RegistrationInteractorInputProtocol {
    weak var presenter: RegistrationInteractorOutputProtocol?
    var firebaseStorageManager: UserAvatarSaveInServerProtocol?
    var authManager: RegistrationProtocol?
    private var avatarTemp = UIImage()

    // MARK: - Register from presenter method
    func registerNewUser(name: String, email: String, password: String) {
        if Reachability.isConnectedToNetwork() {
            if name != "" && email != "" && password != "" {
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

    // MARK: - Support register method
    private func registerUser(name: String, email: String, password: String) {
        authManager?.registerUser(name: name, email: email, password: password) { [weak self] status, uid in
            switch status {
            case .error:
                self?.presenter?.getRegistrationResult(result: .error)
            case .complete:
                let tempImage = UIImage(named: "mockUser_1")!
                let tempUID = UUID().uuidString
                self?.firebaseStorageManager?.saveImage(image: self?.avatarTemp ?? tempImage, name: uid ?? tempUID)
                self?.presenter?.getRegistrationResult(result: .complete)
            default:
                self?.presenter?.getRegistrationResult(result: .error)
            }
        }
    }

    // MARK: - Check permisson for avatar
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
                    if !authorized {
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

    // MARK: - Set temp avatar for upload to server
    func setTempAvatar(_ image: UIImage) {
        self.avatarTemp = image
    }
}
