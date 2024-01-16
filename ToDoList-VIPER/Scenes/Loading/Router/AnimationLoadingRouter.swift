//
//  AnimationScreenRouter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 15.01.2024.
//

import UIKit

protocol AnimationLoadingRouterProtocol: AnyObject {
    static func createLoadingModule() -> UIViewController
    func goToTheApp()
}

final class AnimationLoadingRouter: AnimationLoadingRouterProtocol {
    static func createLoadingModule() -> UIViewController {
        let vc = AnimationLoadingController()
        vc.router = self
        return vc
    }
    
    
  
    
    func goToTheApp() {
      
    }
}

