//
//  MainScreenRouter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 15.03.2024.
//

import UIKit

final class MainScreenRouter: MainScreenRouterProtocol {

    func goToToDos(from view: any MainScreenViewProtocol, status: ToDoListStatus) {
        guard let parrentView = view as? UIViewController else { return }
        let moduleBuilder = AssemblyBuilder()
        let toDosModule = moduleBuilder.createToDosModule(with: status)
        parrentView.navigationController?.pushViewController(toDosModule, animated: true)
    }
}
