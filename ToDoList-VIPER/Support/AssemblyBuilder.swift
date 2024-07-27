//
//  AssemblyBuilder.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 27.07.2024.
//

import UIKit

final class AssemblyBuilder {
    //MARK: - Create base screen's
    func createLoadingModule(_ nextViewComtroller: UIViewController) -> UIViewController {
        let vc = AnimationLoadingController()
        let presenter: AnimationLoadingPresenterProtocol = AnimationLoadingPresenter()
        let router = AnimationLoadingRouter()
        
        vc.presenter = presenter
        vc.nextScreen = nextViewComtroller
        presenter.view = vc
        presenter.router = router
        
        return vc
    }
    
    func createOnboardingModule() -> UIViewController {
        let view = OnboardingPagesController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        let presenter: OnboardingPresenterProtocol & OnboardingInteractorOutputProtocol = OnboardingPresenter()
        let interactor: OnboardingInteractorInputProtocol = OnboardingInteractor()
        let router = OnboardingRouter()
        let navCon = UINavigationController(rootViewController: view)
        navCon.tabBarController?.tabBar.isHidden = true
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return navCon
    }
    
    func createLoginModule() -> UIViewController {
        let viewController = LoginController()
        let presenter: LoginPresenterProtocol & LoginInteractorOutputProtocol = LoginPresenter()
        let interactor: LoginInteractorInputProtocol = LoginInteractor()
        let router: LoginRouterProtocol = LoginRouter()
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        viewController.navigationItem.hidesBackButton = true
        return viewController
    }
    
    func createRegistrationModule() -> UIViewController {
        let view = RegistrationController()
        let presenter: RegistrationPresenterPtorocol & RegistrationInteractorOutputProtocol = RegistrationPresenter()
        let interactor: RegistrationInteractorInputProtocol = RegistrationInteractor()
        let router: RegistrationRouterProtocol = RegistrationRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.presenter = presenter
        return view
    }
    
    func createForgettPasswordModule() -> UIViewController {
        let view = ForgottPasswordController()
        let presenter: ForgettPasswordPresenterProtocol & ForgettPasswordInreractorOutputProtocol = ForgettPasswortPresenter()
        let interactor: ForgettPasswordInreractorInputProtocol = ForgettPasswordInteractor()
        let router: ForgettPasswordRouterProtocol = ForgettPasswordRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return view
    }
}
  //MARK: - Create Home screen method's
extension AssemblyBuilder {
    
    func createHomeTabBar(tabOne: UIViewController, tabTwo: UIViewController) -> UIViewController {
        let tabBar = CustomHomeTabBarController()
        let presenter: HomeTabBarPresenterProtocol = HomeTabBarPresenter()
        let router: HomeTabBarRouterProtocol = HomeTabBarRouter()
        
        let taskScreen = tabOne
        taskScreen.hidesBottomBarWhenPushed = false
        let taskScreenItem = UITabBarItem(title: "Задачи",
                                          image: UIImage(systemName: "list.clipboard.fill"),
                                          tag: 0)
        taskScreen.tabBarItem = taskScreenItem
        
        let optionsScreen = tabTwo
        let optionsScreenItem = UITabBarItem(title: "Опции",
                                             image: UIImage(systemName: "gearshape.fill"),
                                             tag: 1)
        optionsScreen.tabBarItem = optionsScreenItem
        
        tabBar.viewControllers = [taskScreen, optionsScreen]
        tabBar.presenter = presenter
        presenter.view = tabBar
        presenter.router = router
        
        return tabBar
     }
    
    func createAddNewToDoModule() -> UIViewController {
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
    
    func createMainScreenModule() -> UIViewController {
        let viewController = MainScreenController()
        let presenter: MainScreenPresenterProtocol & MainScreenInteractorOutputProtocol = MainScreenPresenter()
        let interactor: MainScreenInteractorInputProtocol = MainScreenInteractor()
        let router: MainScreenRouterProtocol = MainScreenRouter()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return viewController
    }
    
    func createOptionsModule() -> UIViewController {
        let view = OptionsViewController()
        let presenter: OptionsPresenterProtocol & OptionsOutputInteractorProtocol = OptionsPresenter()
        let interactor: OptionsInputInteractorProtocol = OptionsInteractor()
        let router: OptionsRouterProtocol = OptionsRouter()
        let navCon = UINavigationController(rootViewController: view)
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.view = view
        presenter.router = router
        interactor.presenter = presenter
        
        return navCon
    }
    
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
  //MARK: - Create ToDos Screen
extension AssemblyBuilder {
    func createToDosModule(with status: ToDoListStatus) -> UIViewController {
        let view = ToDoController()
        let presenter: ToDosPresenterProtocol & ToDosInteractorOutputProtocol = ToDosPresenter()
        let interactor: ToDosInteractorInputProtocol = ToDosInteractor()
        let router: ToDosRouterProtocol = ToDosRouter()
        
        presenter.status = status
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return view
    }
    
    func createModule(with toDo: ToDoObject) -> UIViewController {
        let viewController: ToDosDetailViewProtocol = ToDosDetailController()
        let presenter: ToDosDetailPresenterProtocol & ToDosDetailInteractorOutputProtocol = ToDosDetailPresenter()
        let interactor: ToDosDetailInteractorInputProtocol = ToDosDetailInteractor()
        let router: ToDosDetailRouterProtocol = ToDosDetailRouter()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        interactor.toDoItem = toDo
        router.presenter = presenter
        
        return viewController as! UIViewController
    }
}
