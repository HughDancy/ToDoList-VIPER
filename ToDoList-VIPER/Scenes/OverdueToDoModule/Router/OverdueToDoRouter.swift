//
//  OverdueToDoRouter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 29.11.2023.
//

import UIKit

final class OverdueToDoRouter: OverdueRouterProtocol {
   
    static func createOverdueModule() -> UIViewController {
        let presenter: OverduePresenterProtocol & OverdueInteractorOutputProtocol = OverduePresenter()
        let interactor: OverdueInteractorInputProtocol = OverdueInteractor()
        let vc = OverdueToDoController()
        let router = OverdueToDoRouter()
        let navCon = UINavigationController(rootViewController: vc)
        
        vc.presenter = presenter
        presenter.view = vc
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return vc
    }
    
    func presentToDoDetailScreen(from view: OverdueViewProtocol, for item: ToDoObject) {
        let toDoDeatailVc = ToDoDetailRouter.createToDoDetailModule(with: item)
        toDoDeatailVc.hidesBottomBarWhenPushed = true
        guard let viewController = view as? UIViewController else { return }
        viewController.navigationController?.pushViewController(toDoDeatailVc, animated: true)
    }
}
