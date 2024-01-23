//
//  OnboardingInteractor.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 17.01.2024.
//

import Foundation
import AVFoundation

final class OnboardingInteractor: OnboardingInteractorInputProtocol {
    var presenter: OnboardingInteractorOutputProtocol?
    let onboardingData = OnboardingItems.pagesData
    
    func retriveData() {
        presenter?.didRetriveData(onboardingData)
    }
    
    func checkPermissions() {
        let cameraStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch cameraStatus {
        case .authorized:
            return
        case .denied:
            print("Acess denied")
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: AVMediaType.video) { (authorized) in
                if (!authorized) {
                    print("Alredy authorized")
                }
            }
        case .restricted:
            print("Restricted")
        @unknown default:
            fatalError()
        }
        
        print("Check permissions")
    }
    
}
