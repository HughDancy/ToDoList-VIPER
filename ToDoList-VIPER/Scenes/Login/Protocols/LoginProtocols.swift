//
//  LoginProtocols.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 24.01.2024.
//

import UIKit

protocol LoginViewProtocol: AnyObject {
    var presenter: OnboardingPresenterProtocol? { get set }
    
}

protocol LoginPresenterProtocol: AnyObject {
    
}
