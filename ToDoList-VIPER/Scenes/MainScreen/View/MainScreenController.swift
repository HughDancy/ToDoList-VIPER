//
//  MainScreenController.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 14.03.2024.
//

import UIKit
import SnapKit

final class MainScreenController: UIViewController {
    
    //MARK: - OUTLETS
    private lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "mainBackgroundImage")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private lazy var userAvatar: UIImageView = {
        let userAvatar = UIImageView()
        userAvatar.image = UIImage(named: "mockUserAvatar")
        userAvatar.contentMode = .scaleAspectFit
        userAvatar.layer.cornerRadius = 30
        userAvatar.clipsToBounds = true
        return userAvatar
    }()
    
    private lazy var userName: UILabel = {
       let userName = UILabel()
        userName.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        userName.textColor = .white
        userName.text = "Привет, Дональд!"
        userName.numberOfLines = 0
        return userName
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 50
        view.clipsToBounds = true
        return view
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
        view.backgroundColor = .systemBackground
    }
    
    //MARK: - SetupHierarchy
    private func setupHierarchy() {
        view.addSubview(backgroundImage)
        view.sendSubviewToBack(backgroundImage)
        view.addSubview(userAvatar)
        view.addSubview(userName)
        view.addSubview(containerView)
    }
    
    //MARK: - Setup Layout
    private func setupLayout() {
        backgroundImage.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(-55)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(350)
        }
        
        userAvatar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(60)
        }
        
        userName.snp.makeConstraints { make in
            make.top.equalTo(userAvatar.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(130)
        }
        
    }
    
    //MARK: -
    
    
    
    
}
