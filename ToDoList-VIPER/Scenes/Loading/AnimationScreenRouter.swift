//
//  AnimationScreenRouter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 15.01.2024.
//

import UIKit

protocol AnimationScreenRouterProtocol: AnyObject {
    func goToTheApp()
}

final class AnimationScreenRouter: AnimationScreenRouterProtocol {
    weak var viewController: AnimationLoadingControllerProtocol?
    
    func goToTheApp() {
        
    }
}

