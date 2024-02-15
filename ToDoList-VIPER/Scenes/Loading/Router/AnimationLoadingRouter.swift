//
//  AnimationScreenRouter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 15.01.2024.
//

import UIKit

protocol AnimationLoadingRouterProtocol: AnyObject {
    static func createLoadingModule() -> UIViewController
    func goToTheApp(fromView: AnimationLoadingControllerProtocol)
}

final class AnimationLoadingRouter: AnimationLoadingRouterProtocol {
   
    static func createLoadingModule() -> UIViewController {
        let vc = AnimationLoadingController()
        let presenter: AnimationLoadingPresenterProtocol = AnimationLoadingPresenter()
        let interactor: AnimationLoadingInteractorInputProtocol = AnimationLoadingInteractor()
        let router = AnimationLoadingRouter()
        
        vc.presenter = presenter
        presenter.view = vc
        presenter.interactor = interactor
        presenter.router = router
       
        return vc
    }
    
    
    func goToTheApp(fromView: AnimationLoadingControllerProtocol) {
        guard let parrentView = fromView as? UIViewController else { return }
        let viewContoller = AppConfigurator.configuator.configureApp()
        viewContoller.modalTransitionStyle = .crossDissolve
        viewContoller.modalPresentationStyle = .fullScreen
        parrentView.present(viewContoller, animated: true)
//        let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
//        appDelegate.window?.rootViewController = viewContoller
        
//        if isNewUser == true {
//            guard let parrentView = fromView as? UIViewController else { return }
//
//            let onboardingModule = OnboardingRouter.createOnboardingModule()
//            onboardingModule.modalTransitionStyle = .crossDissolve
//            onboardingModule.modalPresentationStyle = .fullScreen
//            parrentView.present(onboardingModule, animated: true)
//            let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
//            appDelegate.window?.rootViewController = view
//        } else  {
//            guard let parrentView = fromView as? UIViewController else { return }
//            let view = HomeTabBarRouter.createHomeTabBar()
//            view.modalTransitionStyle = .crossDissolve
//            view.modalPresentationStyle = .fullScreen
//            parrentView.present(view, animated: true)  
//        }
    }
}

