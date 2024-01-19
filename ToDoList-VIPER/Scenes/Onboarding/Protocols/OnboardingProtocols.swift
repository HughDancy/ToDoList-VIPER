//
//  OnboardingProtocols.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 17.01.2024.
//

import UIKit

protocol OnboardingViewProtocol: AnyObject {
    var presenter: OnboardingPresenterProtocol? { get set }
}

protocol OnboardingPresenterProtocol: AnyObject {
    var view: OnboardingViewProtocol? { get set }
    var interactor: OnboardingInteractorProtocol? { get set }
    var router: OnboardingRouterProtocol? { get set }
    
    func goToLoginScreen()
    func checkLogin(nick: String, password: String)
    
}

protocol OnboardingInteractorProtocol: AnyObject {
    func checkLogin(nick: String, password: String) -> Bool
}

protocol OnboardingRouterProtocol: AnyObject {
    static func createOnboardingModule() -> UIViewController
    
    func goToLoginScreen(from view: OnboardingViewProtocol)
}

enum OnboardingStates: String {
    case welcome
    case aboutApp
    case addToDo
    case featureToDo
    case option
}
