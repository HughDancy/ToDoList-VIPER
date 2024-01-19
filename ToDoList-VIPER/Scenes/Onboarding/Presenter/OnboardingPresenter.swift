//
//  OnboardingPresenter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 17.01.2024.
//

import Foundation

final class OnboardingPresenter: OnboardingPresenterProtocol {
    weak var view: OnboardingViewProtocol?
    var interactor: OnboardingInteractorProtocol?
    var router: OnboardingRouterProtocol?
    
    func goToLoginScreen() {
        guard let view = view else { return }
        router?.goToLoginScreen(from: view)
    }
    
    func checkLogin(nick: String, password: String) {
        interactor?.checkLogin(nick: nick, password: password)
    }
    
    
}
