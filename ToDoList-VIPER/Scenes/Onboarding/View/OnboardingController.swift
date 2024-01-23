//
//  OnboardingController.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 19.01.2024.
//

import UIKit

class OnboardingController: UIPageViewController {
 
    //MARK: - Elements
    var presenter: OnboardingPresenterProtocol?
    private var data = [OnboardingItems]()
    private var pages = [OnboardingPageController]()
    private var currentPage = 0
    
    //MARK: - Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
        setupPages()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        //MARK: - REWRITE THIS
//        UserDefaults.standard.setValue(OnboardingStates.welcome.rawValue, forKey: "onboardingState")
        self.dataSource = self
    }
    
    //MARK: - Setup onboarding pages
    private func setupPages() {
        for item in data {
            let vc = OnboardingPageController()
            vc.setupElements(with: item)
            vc.nextScreenButton.addTarget(self, action: #selector(goToNextScreen), for: .touchDown)
            if vc.state == .option {
                vc.photoAndLibraryButton.isHidden = false
            } else {
                vc.view.willRemoveSubview(vc.photoAndLibraryButton)
                vc.photoAndLibraryButton.isHidden = true
            }
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
}

//MARK: - OnboardingViewProtocol Extension
extension OnboardingController: OnboardingViewProtocol {
    func getOnboardingData(_ data: [OnboardingItems]) {
        self.data = data
    }
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
