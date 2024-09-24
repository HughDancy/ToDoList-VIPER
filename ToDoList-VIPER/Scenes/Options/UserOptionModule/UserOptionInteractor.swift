//
//  UserOptionInteractor.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 05.07.2024.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import AVFoundation
import Photos

final class UserOptionInteractor: UserOptionInputInteractorProtocol {

  // MARK: - Properties
    weak var presenter: UserOptionOutputInteractorProtocol?
    private var tempAvatar: UIImage?
    var firebaseStorageManager: UserAvatarSaveInServerProtocol?

    deinit {
           debugPrint("? deinit \(self)")
       }

    // MARK: - Protocol Method's
    func saveUserInfo(name: String) {
        let keychainManager = AuthKeychainManager()
        let userUid = keychainManager.id
        let firebaseDataBase = Firestore.firestore()

        if name != UserDefaults.standard.string(forKey: UserDefaults.Keys.userName) {
            UserDefaults.standard.set(name, forKey: UserDefaults.Keys.userName)
            firebaseDataBase.collection("users").document(userUid ?? UUID().uuidString).setData(["displayName" : name, "name": name], merge: true)
            let user = Auth.auth().currentUser
            let changeRequest = user?.createProfileChangeRequest()
            changeRequest?.displayName = name
            changeRequest?.commitChanges(completion: { error in
                if error != nil {
                    print("error when try save changed user name")
                } else {
                    print("Saving changed user name was succes")
                }
            })
        }

        if tempAvatar != nil {
            firebaseStorageManager?.saveImage(image: tempAvatar ?? UIImage(named: "mockUser_1")!, name: userUid ?? UUID().uuidString)
        }
        NotificationCenter.default.post(name: NotificationNames.updateUserData.name, object: nil)
        presenter?.dismiss()
    }

    func getUserInfo() {
        guard let userName = UserDefaults.standard.string(forKey: UserDefaults.Keys.userName) else {
            presenter?.loadUserName("TestUser")
            return
        }
        presenter?.loadUserName(userName)

        guard let userAvatar = UserDefaults.standard.url(forKey: UserDefaults.Keys.userAvatar) else {
            presenter?.loadUserAvatar(nil)
            return
        }
        presenter?.loadUserAvatar(userAvatar)
    }

    func setTempAvatar(_ image: UIImage?) {
        self.tempAvatar = image
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
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { [weak self] status in
                switch status {
                case .authorized:
                    self?.presenter?.goToImagePicker(with: .gallery)
                    print("Authorized")
                case .denied:
                    self?.presenter?.goToOptions(with: "медиа библиотеке")
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
