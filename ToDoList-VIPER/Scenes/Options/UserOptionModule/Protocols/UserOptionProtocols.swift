//
//  UserOptionProtocols.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 05.07.2024.
//

import UIKit

protocol UserOptionViewProtocol: AnyObject {
    var presenter: UserOptionPresenterProtocol? { get set }
    
    func getUserData(_ data: (String, URL?))
}

protocol UserOptionPresenterProtocol: AnyObject {
    var view: UserOptionViewProtocol? { get set }
    var interactor: UserOptionInputInteractorProtocol? { get set }
    var router: UserOptionRouterProtocol? { get set }
    
    func retriveData()
    func goBack()
    func chooseAvatar()
    func setImage(_ image: UIImage?)
    func saveUserInfo(name: String)
    
    func checkPermission(with status: PermissionStatus)
}

protocol UserOptionInputInteractorProtocol: AnyObject {
    var presenter: UserOptionOutputInteractorProtocol? { get set }
    
    func setTempAvatar(_ image: UIImage?)
    func saveUserInfo(name: String)
    func getUserInfo()
    
    func checkPermission(with status: PermissionStatus)
}

protocol UserOptionOutputInteractorProtocol: AnyObject {
    func loadUserData(_ data: (String, URL?))
    func dismiss()
    
    func goToOptions(with label: String)
    func goToImagePicker(with status: PermissionStatus)
}

protocol UserOptionRouterProtocol: AnyObject {
    var presenter: UserOptionPresenterProtocol? { get set }
    static func createUserOptionModule() -> UIViewController
    
    func goBack(from view: UserOptionViewProtocol)
    func showImageSourceAlert(from view: UserOptionViewProtocol)
    func goToOption(from view: UserOptionViewProtocol, with label: String)
    func goToImagePicker(from view: UserOptionViewProtocol, status: PermissionStatus)
}
