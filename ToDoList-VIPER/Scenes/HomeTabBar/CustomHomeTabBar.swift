//
//  CustomHomeTabBar.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 11.03.2024.
//

import Foundation
import UIKit

final class CustomHomeTabBarController: UITabBarController, UITabBarControllerDelegate {
    private var customTabBar = CustomTabBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self

        setupLayoutCustomTabBar()
        self.selectedIndex = 1
        addSomeTabBarItems()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var tabBarFrame = self.tabBar.frame
        tabBarFrame.size.height = tabBarFrame.height + 40
        tabBarFrame.origin.y = UIScreen.main.bounds.height - 107
        self.tabBar.frame = tabBarFrame
    }
    
    func setupLayoutCustomTabBar() {
        tabBar.addSubview(customTabBar)
        self.tabBar.addSubview(button)

        customTabBar.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalToSuperview().offset(-50)
        }

        button.snp.makeConstraints {
            $0.width.equalTo(60)
            $0.height.equalTo(60)
            $0.centerX.equalToSuperview().offset(5)
            $0.centerY.equalTo(self.customTabBar.snp.top).offset(-5)
        }
    }
    
    private func addSomeTabBarItems() {
        let vc1 = ToDoListRouter.createToDoListModule()
        let vc2 = MockViewController()
        vc1.title = "Home"
        vc2.title = "Options"
        setViewControllers([vc1, vc2], animated: true)
        guard let items = tabBar.items else { return }
        items[0].image = UIImage(systemName: "house.fill")
        items[1].image = UIImage(systemName: "star.fill")
        self.tabBar.itemWidth = 50
        self.tabBar.itemPositioning = .centered
        self.tabBar.itemSpacing = self.view.bounds.width / 1.8
    }
    
    private lazy var button: UIButton = {
//        let middleButton = UIButton(frame: CGRect(x: (self.view.bounds.width / 2) - 25 , y: self.view.bounds.height * 0.87, width: 60, height: 60))
        let middleButton = UIButton()
        middleButton.layer.cornerRadius = 30
        middleButton.clipsToBounds = true
        middleButton.backgroundColor = .systemGreen
        middleButton.tintColor = .systemBackground
        middleButton.setBackgroundImage(UIImage(systemName: "plus"), for: .normal)
        middleButton.isUserInteractionEnabled = true
        middleButton.layer.shadowColor = UIColor.black.cgColor
        middleButton.layer.shadowOpacity = 0.1
        middleButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        self.tabBar.addSubview(middleButton)
        middleButton.addTarget(self, action: #selector(openAddNewToDo), for: .touchUpInside)
        
      
        return middleButton
    }()
    
    @objc func openAddNewToDo() {
        let alertController = UIAlertController(title: "Hey", message: "Hey you press plus button", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Done", style: .cancel))
        self.present(alertController, animated: true)
        self.selectedIndex = 2
        print("Button is pushed")
    }
}


