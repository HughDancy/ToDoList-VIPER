//
//  RegistrationProtocols.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 29.01.2024.
//

import UIKit

protocol RegistrationViewProtocol: AnyObject {
    var presenter: RegistrationPresenterPtorocol? { get set }
    func stopAnimateRegisterButton()
}

protocol RegistrationPresenterPtorocol: AnyObject {
    var view: RegistrationViewProtocol? { get set }
    var interactor: RegistrationInteractorInputProtocol? { get set }
    var rotuter: RegistrationRouterProtocol? { get set }
    
    //VIEW -> PRESENTER
    func registerNewUser(with name: String, email: String, password: String)
}

protocol RegistrationInteractorInputProtocol: AnyObject {
    var presenter: RegistrationInteractorOutputProtocol? { get set }
    
    //PRESENTER -> INTERACTOR
    func registerNewUser(name: String, email: String, password: String)
}

protocol RegistrationInteractorOutputProtocol: AnyObject {
    //INTERACTOR -> PRESENTER
    func getRegistrationResult(result: RegistrationStatus)
}

protocol RegistrationRouterProtocol: AnyObject {
    static func createRegistrationModule() -> UIViewController
    func showAlert(with result: RegistrationStatus, and view: RegistrationViewProtocol)
}


