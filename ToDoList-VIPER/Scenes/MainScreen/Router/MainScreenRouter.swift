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
        
        return navVc
    }
    
    func goTodayToDos(from view: any MainScreenViewProtocol) {
        guard let parrentView = view as? UIViewController else { return }
        let toDayToDos = ToDoListRouter.createToDoListModule()
        parrentView.navigationController?.pushViewController(toDayToDos, animated: true)
    }
    
    func goTomoorowToDos(from view: any MainScreenViewProtocol) {
        guard let parrentView = view as? UIViewController else { return }
        let tommorowToDos = ToDoListRouter.createToDoListModule()
        parrentView.navigationController?.pushViewController(tommorowToDos, animated: true)
    }
    
    func goToOverdueToDos(from view: any MainScreenViewProtocol) {
        guard let parrentView = view as? UIViewController else { return }
        let overdueToDos = OverdueToDoRouter.createOverdueModule()
        parrentView.navigationController?.pushViewController(overdueToDos, animated: true)
    }
    
    func goToDoneToDos(from view: any MainScreenViewProtocol) {
        guard let parrentView = view as? UIViewController else { return }
        let doneToDos = ExecuteToDoRouter.createToDoListModule()
        parrentView.navigationController?.pushViewController(doneToDos, animated: true)
    }
    
    
}
