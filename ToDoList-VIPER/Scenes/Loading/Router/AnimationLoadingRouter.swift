//
//  AnimationScreenRouter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 15.01.2024.
//

import UIKit

protocol AnimationLoadingRouterProtocol: AnyObject {
    func goToTheApp(fromView: AnimationLoadingControllerProtocol)
}

final class AnimationLoadingRouter: AnimationLoadingRouterProtocol {

    func goToTheApp(fromView: AnimationLoadingControllerProtocol) {
        guard let parrentView = fromView as? UIViewController else { return }
        let appConfigurator = AppConfigurator()
        let nextViewController = appConfigurator.configureApp()
        nextViewController.modalTransitionStyle = .crossDissolve
        nextViewController.modalPresentationStyle = .fullScreen
        parrentView.present(nextViewController, animated: true)
    }
}
