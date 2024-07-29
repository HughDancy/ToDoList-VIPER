//
//  AnimationLoadingPresenter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 16.01.2024.
//

import UIKit

protocol AnimationLoadingPresenterProtocol: AnyObject {
    var view: AnimationLoadingControllerProtocol? { get set }
    var router: AnimationLoadingRouterProtocol? { get set }
    
    func goToNextScreen()
}

final class AnimationLoadingPresenter: AnimationLoadingPresenterProtocol {
    weak var view: AnimationLoadingControllerProtocol?
    var router: AnimationLoadingRouterProtocol?
    
    func goToNextScreen() {
        guard let view = view else { return }
        router?.goToTheApp(fromView: view)
    }
}
