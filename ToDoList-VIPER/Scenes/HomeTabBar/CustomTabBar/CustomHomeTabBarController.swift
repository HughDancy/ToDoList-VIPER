//
//  CustomHomeTabBar.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 11.03.2024.
//

import Foundation
import UIKit

final class CustomHomeTabBarController: UITabBarController, UITabBarControllerDelegate, HomeTabBarViewProtocol {
    var presenter: HomeTabBarPresenterProtocol?
    
    private var customTabBar = CustomTabBar()
    
    private var transition = CircularTransition()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        setupLayoutCustomTabBar()
        self.selectedIndex = 1
        setupPositionTabBarItem()
        self.navigationItem.largeTitleDisplayMode = .never
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var tabBarFrame = self.tabBar.frame
        tabBarFrame.size.height = tabBarFrame.height + 40
        tabBarFrame.origin.y = UIScreen.main.bounds.height - 107
        self.tabBar.frame = tabBarFrame
    }
    
    //MARK: - Setup Layout
    func setupLayoutCustomTabBar() {
        tabBar.addSubview(customTabBar)
        self.tabBar.addSubview(middleButton)
        
        customTabBar.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalToSuperview().offset(-50)
        }
        
        middleButton.snp.makeConstraints {
            $0.width.equalTo(60)
            $0.height.equalTo(60)
            $0.centerX.equalToSuperview().offset(5)
            $0.centerY.equalTo(self.customTabBar.snp.top).offset(-5)
        }
    }
    
    private func setupPositionTabBarItem() {
        self.tabBar.itemWidth = 50
        self.tabBar.itemPositioning = .centered
        self.tabBar.itemSpacing = self.view.bounds.width / 1.8
    }
    
    //MARK: - Middle button
    lazy var middleButton: UIButton = {
        //        let middleButton = UIButton(frame: CGRect(x: (self.view.bounds.width / 2) - 25 , y: self.view.bounds.height * 0.87, width: 60, height: 60))
        let middleButton = UIButton()
        middleButton.layer.cornerRadius = 30
        middleButton.clipsToBounds = true
        middleButton.backgroundColor = UIColor(named: "coralColor")
        middleButton.tintColor = .systemBackground
        let buttonImage = UIImageView(image: UIImage(systemName: "plus"))
        middleButton.addSubview(buttonImage)
        buttonImage.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.width.equalTo(30)
        }
        middleButton.isUserInteractionEnabled = true
        middleButton.layer.shadowColor = UIColor.black.cgColor
        middleButton.layer.shadowOpacity = 0.4
        middleButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        self.tabBar.addSubview(middleButton)
        middleButton.addTarget(self, action: #selector(openAddNewToDo), for: .touchUpInside)
        return middleButton
    }()
    
    @objc func openAddNewToDo() {
        presenter?.presentAddNewToDo()
    }
}

extension CustomHomeTabBarController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {
        transition.transitionMode = .present
        transition.startingPoint = CGPoint(x: (tabBar.center.x + 5.0), y: (tabBar.center.y - 15.0))
        print(middleButton.center)
        transition.circleColor = middleButton.backgroundColor ?? UIColor.systemCyan
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {
        transition.transitionMode = .dismiss
        transition.startingPoint = CGPoint(x: (tabBar.center.x + 5.0), y: (tabBar.center.y - 15.0))
        transition.circleColor = middleButton.backgroundColor ?? UIColor.systemCyan
        return transition
    }
}

