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
    func changeRootContorller(_ nextViewController: UIViewController)
}

final class AnimationLoadingRouter: AnimationLoadingRouterProtocol {
//    private var currentControoler: UIViewController?
    
    static func createLoadingModule(_ nextViewComtroller: UIViewController) -> UIViewController {
//        let vc = AnimationLoadingController(nextViewComtroller)
        let vc = AnimationLoadingController()
        let presenter: AnimationLoadingPresenterProtocol = AnimationLoadingPresenter()
        let interactor: AnimationLoadingInteractorInputProtocol = AnimationLoadingInteractor()
        let router = AnimationLoadingRouter()
        
        vc.presenter = presenter
        vc.nextScreen = nextViewComtroller
        presenter.view = vc
        presenter.interactor = interactor
        presenter.router = router
       
        return vc
    }
    
    
    func goToTheApp(fromView: AnimationLoadingControllerProtocol, to nextViewController: UIViewController) {
        guard let parrentView = fromView as? UIViewController else { return }
//        let viewContoller = AppConfigurator.configuator.configureApp()
//        self.currentControoler = nextViewController
        nextViewController.modalTransitionStyle = .crossDissolve
        nextViewController.modalPresentationStyle = .fullScreen
        parrentView.present(nextViewController, animated: true)
//        self.changeRootContorller(nextViewController)
 

        
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
    
    func changeRootContorller(_ nextViewController: UIViewController) {
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
        sceneDelegate.window?.rootViewController = nextViewController
    }
}

