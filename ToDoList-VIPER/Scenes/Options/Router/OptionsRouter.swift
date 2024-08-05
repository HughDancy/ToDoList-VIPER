//
//  OptionsRouter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 03.07.2024.
//

import UIKit
import MessageUI

final class OptionsRouter: OptionsRouterProtocol {

    func goToUserOptions(from view: OptionsViewProtocol) {
        guard let parrentView = view as? UIViewController else { return }
        let builder = AssemblyBuilder()
        let userOptionModule =  builder.createUserOptionModule()
        parrentView.navigationController?.pushViewController(userOptionModule, animated: true)
    }

    func logOut(from view: OptionsViewProtocol) {
        guard let parrentView = view as? UIViewController else { return }
        parrentView.tabBarController?.tabBar.isHidden = true
        print("WHEN LOG OUT METHOD WORK USERDEFAULTS VALUE IS - \(UserDefaults.standard.bool(forKey: UserDefaultsNames.firstWorkLaunch.name))")
        if UserDefaults.standard.bool(forKey: UserDefaultsNames.firstWorkLaunch.name) {
            parrentView.dismiss(animated: true)
        } else {
            let loginModule = AppConfigurator.configuator.logOut()
            let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
            sceneDelegate?.window?.rootViewController = loginModule
            parrentView.navigationController?.popToRootViewController(animated: true)
        }
    }

    func getFeedback(from view: OptionsViewProtocol) {
        guard let parrentView = view as? UIViewController else { return }
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = parrentView as? any MFMailComposeViewControllerDelegate
            mail.setToRecipients(["hugh.dancy@icloud.com"])
            mail.setMessageBody("<p>Привет! Я пользуюсь твоим приложением ToDoList-VIPER и хотел бы дать обратную связь:</p>", isHTML: true)

            parrentView.present(mail, animated: true)
        } else {
            print("Email not work")
        }
    }
}
