//
//  OnboardingController.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 19.01.2024.
//

import UIKit

class OnboardingPagesController: UIPageViewController {
 
    //MARK: - Elements
    var presenter: OnboardingPresenterProtocol?
    private var data = [OnboardingItems]()
    private var pages = [OnboardingPage]()
    private var currentPage = 0
    
    //MARK: - Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        presenter?.viewWillAppear()
        setupPages()
        setupFirstPage()
        print(currentPage)
        self.dataSource = self
    }
    
    //MARK: - Setup onboarding pages
    private func setupPages() {
        for item in data {
            let vc = OnboardingPage()
            vc.state = item.state
            vc.setupElements(with: item)
            vc.nextScreenButton.addTarget(self, action: #selector(goToLogin), for: .touchDown)
            if vc.state == .option {
                vc.nextScreenButton.isHidden = false
            }
            pages.append(vc)
        }
    }
    
    private func setupFirstPage() {
        if let firstPage = pages.first(where: { page in
                  page.state?.rawValue ?? OnboardingStates.welcome.rawValue == UserDefaults.standard.string(forKey: "onboardingState")
              })  {
                  setViewControllers([firstPage], direction: .forward, animated: true, completion: nil)
            self.currentPage = pages.firstIndex(of: firstPage) ?? 0
              }

    }
  
    //MARK: - @OBJC METHODS
    @objc func goToNextScreen() {
        if currentPage + 1 < pages.count {
                self.setViewControllers([self.pages[self.currentPage + 1]], direction: .forward, animated: true)
                self.currentPage = self.currentPage + 1
        }
    }

    @objc func goToLogin() {
        presenter?.goToLoginModule()
    }
}

//MARK: - OnboardingViewProtocol Extension
extension OnboardingPagesController: OnboardingViewProtocol {
    func getOnboardingData(_ data: [OnboardingItems]) {
        self.data = data
    }
}

   //MARK: - Page Controller delegate and data source Extension
extension OnboardingPagesController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = pages.firstIndex(of: viewController as! OnboardingPage) {
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
        if let index = pages.firstIndex(of: viewController as! OnboardingPage) {
            if index < pages.count - 1 {
                return pages[index + 1]
            } else {
                return nil
            }
        }
        return nil
    }
}
