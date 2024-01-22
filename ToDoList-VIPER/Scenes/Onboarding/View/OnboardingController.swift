//
//  OnboardingController.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 19.01.2024.
//

import UIKit

class OnboardingController: UIPageViewController, OnboardingViewProtocol {
 
    //MARK: - Elements
    var presenter: OnboardingPresenterProtocol?
    private var pages = [OnboardingPageController]()
    private var currentPage = 0
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.setValue(OnboardingStates.welcome.rawValue, forKey: "onboardingState")
        setupPages()
        self.dataSource = self

       
    }
    
    //MARK: - Setup onboarding pages
    private func setupPages() {
        let pagesData: [(String,  String?, String, UIImage?, OnboardingStates)] = [
            ("Welcome to ToDo List App", nil,"Begin", UIImage(named: "welcomeImage"), OnboardingStates.welcome),
            ("Our App for youre everyday ToDos", "Make your ToDos in a simply order", "Next", nil, OnboardingStates.aboutApp),
            ("Add new ToDo Simple!", "Just push plus button and fill the needed fields" ,"Next", nil, OnboardingStates.addToDo),
            ("Customize your profile!", "We need to acces to your gallery, for avatar" ,"Next", nil, OnboardingStates.option)
        ]
        
        for (label, description, buttonText, image, state) in pagesData {
            let vc = OnboardingPageController()
            vc.setupElements(label: label, description: description ?? "", buttonText: buttonText, image: image, state: state )
            vc.nextScreenButton.addTarget(self, action: #selector(goToNextScreen), for: .touchDown)
            pages.append(vc)
        }

        if let firstPage = pages.first(where: { page in
            page.state?.rawValue ?? OnboardingStates.welcome.rawValue == UserDefaults.standard.string(forKey: "onboardingState")
        })  {
            setViewControllers([firstPage], direction: .forward, animated: true, completion: nil)
        }
    }
    
    @objc func goToNextScreen() {
        if currentPage + 1 < pages.count {
            self.setViewControllers([pages[currentPage + 1]], direction: .forward, animated: true)
            currentPage = currentPage + 1
        }
       
    }
    
    //MARK: - Something

  

}

   //MARK: - Page Controller delegate and data source Extension
extension OnboardingController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = pages.firstIndex(of: viewController as! OnboardingPageController) {
            if index > 0 {
                self.currentPage = index - 1
                return pages[index - 1]
            } else {
                return nil
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = pages.firstIndex(of: viewController as! OnboardingPageController) {
            if index < pages.count - 1 {
                return pages[index + 1]
            } else {
                return nil
            }
        }
        return nil
    }
    
    
}
