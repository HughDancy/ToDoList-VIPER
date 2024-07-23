//
//  AddNewToDoRouter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 18.03.2024.
//

import UIKit

final class AddNewToDoRouter: AddNewToDoRouterProtocol {
    static func createAddNewToDoModule() -> UIViewController {
        let view = AddNewToDoController()
        let presenter: AddNewToDoPresenterProtocol = AddNewToDoPresenter()
        let interactor: AddNewToDoInteractorProtocol = AddNewToDoInteractor()
        let router: AddNewToDoRouterProtocol = AddNewToDoRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        return view
    }
    
    func dismiss(from view: any AddNewToDoViewProtocol) {
        guard let parrentView = view as? UIViewController else { return }
        parrentView.dismiss(animated: true)
    }
    
    func showAlert(from view: any AddNewToDoViewProtocol) {
        guard let parrentView = view as? UIViewController else { return }
        let alertController = CustomAlertController()
        alertController.modalPresentationStyle = .overCurrentContext
        alertController.modalTransitionStyle = .crossDissolve
        parrentView.present(alertController, animated: true)
        alertController.present(
            type: .oneButton,
            title: "Ошибка",
            message: "Не заполненно наименование задачи",
            imageName: "error",
            colorOne: .systemCyan,
            colorTwo: nil,
            buttonText: "Ок",
            buttonTextTwo: nil
        ) { _ in }
    }
}
