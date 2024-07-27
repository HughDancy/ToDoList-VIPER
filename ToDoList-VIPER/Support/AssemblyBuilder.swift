//
//  AssemblyBuilder.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 27.07.2024.
//

import UIKit

final class AssemblyBuilder {
    func createUserOptionModule() -> UIViewController {
        let view = UserOptionController()
        let presenter: UserOptionPresenterProtocol & UserOptionOutputInteractorProtocol = UserOptionPresenter()
        let interactor: UserOptionInputInteractorProtocol = UserOptionInteractor()
        let router: UserOptionRouter = UserOptionRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.presenter = presenter
        
        return view
    }
}
