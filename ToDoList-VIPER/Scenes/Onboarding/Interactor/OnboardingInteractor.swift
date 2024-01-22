//
//  OnboardingInteractor.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 17.01.2024.
//

import Foundation

final class OnboardingInteractor: OnboardingInteractorInputProtocol {
    var presenter: OnboardingInteractorOutputProtocol?
    let onboardingData = OnboardingItems.pagesData
    
    func retriveData() {
        presenter?.didRetriveData(onboardingData)
    }
    
}
