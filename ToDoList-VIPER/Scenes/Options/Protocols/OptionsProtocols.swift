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
    var view: OptionsPresenterProtocol? { get set }
    var interactor: OptionsInputInteractorProtocol? { get set }
    var router: OptionsRouterProtocol? { get set }
    
    func getData()
    func goToUserOptions()
    func logOut()
    func getFeedback()
    func changeTheme()
}

protocol OptionsInputInteractorProtocol: AnyObject {
    var presenter: OptionsOutputInteractorProtocol? { get set }
    func fetchOptionsData()
    func getUserData()
    func changeTheme()
}


protocol OptionsOutputInteractorProtocol: AnyObject {
    func getOptionsData(_ data: [String])
    func getUserData(_ userData: (String, URL))
}

protocol OptionsRouterProtocol: AnyObject {
    func createOptionsModule() -> UIViewController
    func goToUserOptions(from view: OptionsViewProtocol)
    func logOut(from view: OptionsViewProtocol)
}
