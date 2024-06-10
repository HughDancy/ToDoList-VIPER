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
    var router: RegistrationRouterProtocol? { get set }
    
    //VIEW -> PRESENTER
    func registerNewUser(with name: String, email: String, password: String)
    func chooseImageSource()
    
    //ROUTER -> PRESENTER
    func checkPermission(with status: PermissionStatus)
}

protocol RegistrationInteractorInputProtocol: AnyObject {
    var presenter: RegistrationInteractorOutputProtocol? { get set }
    
    //PRESENTER -> INTERACTOR
    func registerNewUser(name: String, email: String, password: String)
    func checkPermission(with status: PermissionStatus)
}

protocol RegistrationInteractorOutputProtocol: AnyObject {
    //INTERACTOR -> PRESENTER
    func getRegistrationResult(result: RegistrationStatus)
    func goToOptions(with label: String)
}

protocol RegistrationRouterProtocol: AnyObject {
    var presenter: RegistrationPresenterPtorocol? { get set }
    static func createRegistrationModule() -> UIViewController
    func showAlert(with result: RegistrationStatus, and view: RegistrationViewProtocol)
    func showImageSourceAlert(from view: RegistrationViewProtocol)
    func goToOption(from view: RegistrationViewProtocol, with label: String)
}

enum PermissionStatus {
    case camera
    case gallery
}


