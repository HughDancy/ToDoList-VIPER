//
//  OnboardingRouter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 17.01.2024.
//

import UIKit

final class OnboardingRouter: OnboardingRouterProtocol {
    
    func goToLoginModule(from view: OnboardingViewProtocol) {
        guard let parrentView = view as? UIViewController else { return}
        let moduleBuilder = AssemblyBuilder()
        let loginModule = moduleBuilder.createLoginModule()
        parrentView.navigationController?.pushViewController(loginModule, animated: true)
    }
}
