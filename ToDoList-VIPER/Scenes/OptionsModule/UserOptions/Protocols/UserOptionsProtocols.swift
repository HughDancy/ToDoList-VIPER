//
//  UserOptionsProtocols.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 29.12.2023.
//

import UIKit

enum AvatarPickerState {
    case camera
    case mediaLibraty
}

protocol UserOptionViewProtocol: AnyObject {
    var presenter: UserOptionsPresenterProtocol? { get set }
    func getUserData(nickname: String, avatar: UIImage)
}

protocol UserOptionsPresenterProtocol: AnyObject {
    var view: UserOptionViewProtocol? { get set }
    var interactor: UserOptionsInputInteractorProtocol? { get set }
    var router: UserOptionsRouterProtocol? { get set }
    
    //MARK: - VIEW -> PRESENTER
    func viewWillAppear()
    func goToImagePicker(with state: AvatarPickerState)
    func saveTheChanges(nickname: String, avatar: UIImage)
}

protocol UserOptionsInputInteractorProtocol: AnyObject {
    var presenter: UserOptionsOutputInteractorProtocol? { get set }
    
    //MARK: - PRESENTER -> INTERACTOR
     func fetchUserData()
     func saveNewUserData(nickname: String, avatar: UIImage)
}

protocol UserOptionsOutputInteractorProtocol: AnyObject {
    
    //MARK: - INTERACTOR -> PRESENTER
    func putUserData(nickname: String, avatar: UIImage)
    
}

protocol UserOptionsRouterProtocol: AnyObject {
    static func createUserOptionsModule() -> UIViewController
    
    //MARK: - PRESENTER -> ROUTER
    func goToImagePicker(with state: AvatarPickerState)
    func goBackToOptions(with controller: UserOptionViewProtocol)
}
