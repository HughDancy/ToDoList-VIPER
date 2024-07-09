//
//  OptionsRouter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 03.07.2024.
//

import UIKit
import MessageUI

final class OptionsRouter: OptionsRouterProtocol {
    //MARK: -
    
    static func createOptionsModule() -> UIViewController {
        let view = OptionsViewController()
        let presenter: OptionsPresenterProtocol & OptionsOutputInteractorProtocol = OptionsPresenter()
        let interactor: OptionsInputInteractorProtocol = OptionsInteractor()
        let router: OptionsRouterProtocol = OptionsRouter()
        let navCon = UINavigationController(rootViewController: view)
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.view = view
        presenter.router = router
        interactor.presenter = presenter
        
        return navCon
    }
    
    //MARK: - Router Methods
    func goToUserOptions(from view: OptionsViewProtocol) {
        guard let parrentView = view as? UIViewController else { return }
        let userOptionModule = UserOptionRouter.createUserOptionModule()
        parrentView.navigationController?.pushViewController(userOptionModule, animated: true)
    }
    
    func logOut(from view:  OptionsViewProtocol) {
        guard let parrentView = view as? UIViewController else { return }
        parrentView.tabBarController?.tabBar.isHidden = true
//        NewUserCheck.shared.setIsNewUser()
        NewUserCheck.shared.setIsLoginScrren()
        NewUserCheck.shared.setIsNotFirstStartOnboarding()
        let loginModule = AppConfigurator.configuator.logOut()
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
        sceneDelegate.window?.rootViewController = loginModule
        parrentView.navigationController?.popToRootViewController(animated: true)
    }
    
    func getFeedback(from view: OptionsViewProtocol) {
        guard let parrentView = view as? UIViewController else { return }
        if MFMailComposeViewController.canSendMail() {
                let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = parrentView as? any MFMailComposeViewControllerDelegate
                mail.setToRecipients(["hugh.dancy@icloud.com"])
                mail.setMessageBody("<p>Привет! Я пользуюсь твоим приложением ToDoList-VIPER</p>", isHTML: true)

              parrentView.present(mail, animated: true)
            } else {
                print("Email not work")
                // show failure alert
            }
    }
}
