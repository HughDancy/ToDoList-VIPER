//
//  OnboardingPresenter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 17.01.2024.
//

import Foundation

final class OnboardingPresenter: OnboardingPresenterProtocol {
    weak var view: OnboardingViewProtocol?
    var interactor: OnboardingInteractorInputProtocol?
    var router: OnboardingRouterProtocol?
    
    func goToLoginModule() {
        guard let view = view else { return }
        router?.goToLoginModule(from: view)
    }

    func viewWillAppear() {
        interactor?.retriveData()
    }
    
}

extension OnboardingPresenter: OnboardingInteractorOutputProtocol {
    func didRetriveData(_ data: [OnboardingItems]) {
        view?.getOnboardingData(data)
    }
}
