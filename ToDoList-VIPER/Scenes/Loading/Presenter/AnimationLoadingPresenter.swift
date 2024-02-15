//
//  AnimationLoadingPresenter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 16.01.2024.
//

import Foundation

protocol AnimationLoadingPresenterProtocol: AnyObject {
    var view: AnimationLoadingControllerProtocol? { get set }
    var interactor: AnimationLoadingInteractorInputProtocol? { get set }
    var router: AnimationLoadingRouterProtocol? { get set }
    
    func goToNextScreen()
}

final class AnimationLoadingPresenter: AnimationLoadingPresenterProtocol {
    weak var view: AnimationLoadingControllerProtocol?
    var interactor: AnimationLoadingInteractorInputProtocol?
    var router: AnimationLoadingRouterProtocol?
    
    func goToNextScreen() {
        guard let view = view else { return }
//        guard let newUserCheck = interactor?.checkTheUser() else { return }
        router?.goToTheApp(fromView: view )
    }
}
