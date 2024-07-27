//
//  ToDosRouter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 30.03.2024.
//

import UIKit

final class ToDosRouter: ToDosRouterProtocol {
    func goToTask(_ task: ToDoObject, from view: any ToDosViewProtocol) {
        guard let parrentView = view as? UIViewController else { return }
        let moduleBuilder = AssemblyBuilder()
        let toDoDetailModule = moduleBuilder.createModule(with: task)
        let detailModule = ToDosDetailController()
        detailModule.item = task
        parrentView.navigationController?.pushViewController(toDoDetailModule, animated: true)
    }
}
