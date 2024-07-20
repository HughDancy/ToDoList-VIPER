//
//  AnimationScreenRouter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 15.01.2024.
//

import UIKit

protocol AnimationLoadingRouterProtocol: AnyObject {
    static func createLoadingModule(_ nextViewController: UIViewController) -> UIViewController
    func goToTheApp(fromView: AnimationLoadingControllerProtocol, to nextViewController: UIViewController)
}

final class AnimationLoadingRouter: AnimationLoadingRouterProtocol {
    static func createLoadingModule(_ nextViewComtroller: UIViewController) -> UIViewController {
        let vc = AnimationLoadingController()
        let presenter: AnimationLoadingPresenterProtocol = AnimationLoadingPresenter()
        let router = AnimationLoadingRouter()
        
        vc.presenter = presenter
        vc.nextScreen = nextViewComtroller
        presenter.view = vc
        presenter.router = router
       
        return vc
    }
    
    
    func goToTheApp(fromView: AnimationLoadingControllerProtocol, to nextViewController: UIViewController) {
        guard let parrentView = fromView as? UIViewController else { return }
        nextViewController.modalTransitionStyle = .crossDissolve
        nextViewController.modalPresentationStyle = .fullScreen
        parrentView.present(nextViewController, animated: true)
    }
}

