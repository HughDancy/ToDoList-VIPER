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
   
  //MARK: - Properties
    var presenter: UserOptionOutputInteractorProtocol?
    private let db = Firestore.firestore()
    private var storageManager = FirebaseStorageManager()
    private var tempAvatar: UIImage? = nil
    
    //MARK: - Protocol Method's
    func saveUserInfo(name: String) {
        let keychainManager = AuthKeychainManager()
        let userUid = keychainManager.id
        let mockAvatar = UIImage(named: "mockUser_1")!
        if name != UserDefaults.standard.string(forKey: NotificationNames.userName.rawValue) {
            UserDefaults.standard.set(name, forKey: NotificationNames.userName.rawValue)
            db.collection("users").document(userUid ?? UUID().uuidString).setData(["displayName" : name, "name": name], merge: true)
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
            storageManager.saveImage(image: tempAvatar ?? mockAvatar, name: userUid ?? UUID().uuidString)
            print(userUid)
        }
        NotificationCenter.default.post(name: NotificationNames.updateUserData.name, object: nil)
        presenter?.dismiss()
        
    }
    
    func getUserInfo() {
        guard let userName = UserDefaults.standard.string(forKey: NotificationNames.userName.rawValue),
              let userAvatar = UserDefaults.standard.url(forKey: "UserAvatar") else {
            presenter?.loadUserData(("UserAvatar", nil))
            return
        }
        presenter?.loadUserData((userName, userAvatar))
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
