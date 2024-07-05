//
//  OptionsProtocols.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 03.07.2024.
//

import UIKit

protocol OptionsViewProtocol: AnyObject {
    var presenter: OptionsPresenterProtocol? { get set }
    
    func getOptionsData(_ data: [String])
    func getUserData(_ userData: (String, URL))
}

protocol OptionsPresenterProtocol: AnyObject {
    var view: OptionsViewProtocol? { get set }
    var interactor: OptionsInputInteractorProtocol? { get set }
    var router: OptionsRouterProtocol? { get set }
    
    func getData()
    func goToUserOptions()
    func logOut()
    func getFeedback()
    func changeTheme(_ bool: Bool)
}

protocol OptionsInputInteractorProtocol: AnyObject {
    var presenter: OptionsOutputInteractorProtocol? { get set }
    func fetchOptionsData()
    func fetchUserData()
    func changeTheme(_ bool: Bool)
    func loggedOut()
}


protocol OptionsOutputInteractorProtocol: AnyObject {
    func getOptionsData(_ data: [String])
    func getUserData(_ userData: (String, URL))
}

protocol OptionsRouterProtocol: AnyObject {
    static func createOptionsModule() -> UIViewController
    func goToUserOptions(from view: OptionsViewProtocol)
    func logOut(from view: OptionsViewProtocol)
    func getFeedback(from view: OptionsViewProtocol)
}

protocol OptionCellDelegate: AnyObject {
    func changeTheme(_ bool: Bool)
}
