//
//  OnboardingInteractor.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 17.01.2024.
//

import Foundation
import AVFoundation
import Photos

final class OnboardingInteractor: OnboardingInteractorInputProtocol {
    var presenter: OnboardingInteractorOutputProtocol?
    let onboardingData = OnboardingItems.pagesData
    
    func retriveData() {
        presenter?.didRetriveData(onboardingData)
    }
    
    func checkPermissions() {
      checkCameraAccess()
        checkMediaAcces()
        
    }
    
    func checkCameraAccess() {
        let cameraStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch cameraStatus {
        case .authorized:
            return
        case .denied:
            print("Acess denied")
            abort()
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
    }
    
    func checkMediaAcces() {
        let photoStatusAccess = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
            switch status {
            case .authorized:
                print("Authorized")
            case .denied:
                print("Denied")
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
