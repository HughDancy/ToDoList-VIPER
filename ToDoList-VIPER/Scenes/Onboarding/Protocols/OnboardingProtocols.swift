//
//  OnboardingProtocols.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 17.01.2024.
//

import UIKit

protocol OnboardingViewProtocol: AnyObject {
    var presenter: OnboardingPresenterProtocol? { get set }
    
    func getOnboardingData(_ data: [OnboardingItems])
}

protocol OnboardingPresenterProtocol: AnyObject {
    var view: OnboardingViewProtocol? { get set }
    var interactor: OnboardingInteractorInputProtocol? { get set }
    var router: OnboardingRouterProtocol? { get set }
    
    //VIEW -> PRESENTER
    func viewWillAppear()
    func presentRequestAcess()
    func goToLoginModule()
    
    
}

protocol OnboardingInteractorInputProtocol: AnyObject {
    var presenter: OnboardingInteractorOutputProtocol? { get set }
    
    //PRESENTER -> INTERACTOR
    func retriveData()
    func checkPermissions()
}

protocol OnboardingInteractorOutputProtocol: AnyObject {
    //INTERACTOR -> PRESENTER
    func didRetriveData(_ data: [OnboardingItems])
}

protocol OnboardingRouterProtocol: AnyObject {
    static func createOnboardingModule() -> UIViewController
    func presentRequestAcess(from view: OnboardingViewProtocol)
    func goToLoginModule(from view: OnboardingViewProtocol)
}

enum OnboardingStates: String {
    case welcome
    case aboutApp
    case addToDo
    case featureToDo
    case doneAndOvedueToDo
    case option
}
