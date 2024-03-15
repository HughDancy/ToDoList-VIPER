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
        
        return viewController
    }
    
    func goTodayToDos(from view: any MainScreenViewProtocol) {
        <#code#>
    }
    
    func goTomoorowToDos(from view: any MainScreenViewProtocol) {
        <#code#>
    }
    
    func goTo(from view: any MainScreenViewProtocol) {
        <#code#>
    }
    
    func goToDoneToDos(from view: any MainScreenViewProtocol) {
        <#code#>
    }
    
    
}
