//
//  UserOptionRouter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 05.07.2024.
//

import UIKit

final class UserOptionRouter: UserOptionRouterProtocol {
    static func createUserOptionModule() -> UIViewController {
        let view = UserOptionController()
        let presenter: UserOptionPresenterProtocol & UserOptionOutputInteractorProtocol = UserOptionPresenter()
        let interactor: UserOptionInputInteractorProtocol = UserOptionInteractor()
        let router: UserOptionRouterProtocol = UserOptionRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return view
    }
    
    func goBack(from view: any UserOptionViewProtocol) {
        guard let view = view as? UIViewController else { return }
        view.navigationController?.popViewController(animated: true)
    }
    
    func chooseAvatarSource(from view: any UserOptionViewProtocol) {
        print("Dome fincl ")
    }
    
    
}
