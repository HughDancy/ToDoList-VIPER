//
//  MainScreenRouter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 15.03.2024.
//

import UIKit

final class MainScreenRouter: MainScreenRouterProtocol {
 
    static func createMainScreenModule() -> UIViewController {
        let viewController = MainScreenController()
        let presenter: MainScreenPresenterProtocol & MainScreenInteractorOutputProtocol = MainScreenPresenter()
        let interactor: MainScreenInteractorInputProtocol = MainScreenInteractor()
        let router: MainScreenRouterProtocol = MainScreenRouter()
        let navVc = UINavigationController(rootViewController: viewController)
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
//        return navVc
        return viewController
    }
    
    func goTodayToDos(from view: any MainScreenViewProtocol) {
        guard let parrentView = view as? UIViewController else { return }
        let toDayToDos = ToDosRouter.createToDosModule(with: .today)
        parrentView.navigationController?.pushViewController(toDayToDos, animated: true)
    }
    
    func goTomoorowToDos(from view: any MainScreenViewProtocol) {
        guard let parrentView = view as? UIViewController else { return }
        let tommorowToDos = ToDosRouter.createToDosModule(with: .tommorow)
        parrentView.navigationController?.pushViewController(tommorowToDos, animated: true)
    }
    
    func goToOverdueToDos(from view: any MainScreenViewProtocol) {
        guard let parrentView = view as? UIViewController else { return }
        let overdueToDos = ToDosRouter.createToDosModule(with: .overdue)
        parrentView.navigationController?.pushViewController(overdueToDos, animated: true)
    }
    
    func goToDoneToDos(from view: any MainScreenViewProtocol) {
        guard let parrentView = view as? UIViewController else { return }
        let doneToDos = ToDosRouter.createToDosModule(with: .done)
        parrentView.navigationController?.pushViewController(doneToDos, animated: true)
    }
}
