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
        setupPositionTabBarItem()
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
    
    lazy var middleButton: UIButton = {
        //        let middleButton = UIButton(frame: CGRect(x: (self.view.bounds.width / 2) - 25 , y: self.view.bounds.height * 0.87, width: 60, height: 60))
        let middleButton = UIButton()
        middleButton.layer.cornerRadius = 30
        middleButton.clipsToBounds = true
        middleButton.backgroundColor = .systemCyan
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
        let alertController = UIAlertController(title: "Hey", message: "Hey you press plus button", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Done", style: .cancel))
        self.present(alertController, animated: true)
        self.selectedIndex = 2
        print("Button is pushed")
    }
}


