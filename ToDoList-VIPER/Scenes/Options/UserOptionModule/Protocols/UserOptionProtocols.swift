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
    func saveUserInfo()
    
}

protocol UserOptionInputInteractorProtocol: AnyObject {
    var presenter: UserOptionOutputInteractorProtocol? { get set }
    
    func saveUserInfo()
    func getUserInfo()
}

protocol UserOptionOutputInteractorProtocol: AnyObject {
    func loadUserData(_ data: (String, URL?))
}

protocol UserOptionRouterProtocol: AnyObject {
    static func createUserOptionModule() -> UIViewController
    
    func goBack(from view: UserOptionViewProtocol)
    func chooseAvatarSource(from view: UserOptionViewProtocol)
}
