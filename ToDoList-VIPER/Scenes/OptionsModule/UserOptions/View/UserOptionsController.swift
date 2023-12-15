//
//  UserOptionsController.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 15.12.2023.
//

import UIKit

final class UserOptionsController: UIViewController {

    //MARK: - Elements
    private lazy var avatarImage: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 200 / 2
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "testAva")
        
        return imageView
    }()
    
    private lazy var changeAvatarButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Изменить аватар", for: .normal)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        
        return button
    }()
    
    private lazy var userNickname: UITextField = {
       let nickname = UITextField()
        nickname.placeholder = "User name"
        nickname.borderStyle = .roundedRect
        nickname.backgroundColor = .systemGray6
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        nickname.leftView = view
        nickname.leftViewMode = .always
        
        return nickname
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Сохранить изменения", for: .normal)
        button.backgroundColor = .systemGreen
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        
        return button
    }()
    
    //MARK: - Lifecycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        overrideUserInterfaceStyle = ToDoUserDefaults.shares.theme.getUserInterfaceStyle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupHierarchy()
        setupLayout()
    }
    

    //MARK: - Setup Elements
    private func setupHierarchy() {
        view.addSubview(avatarImage)
        view.addSubview(changeAvatarButton)
        view.addSubview(userNickname)
        view.addSubview(saveButton)
    }
    
    private func setupLayout() {
        avatarImage.snp.makeConstraints { make in
            make.centerY.centerX.equalTo(view.safeAreaLayoutGuide)
            make.height.width.equalTo(200)
        }
        
        changeAvatarButton.snp.makeConstraints { make in
            make.top.equalTo(avatarImage.snp.bottom).offset(10)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.height.equalTo(35)
        }
        
        userNickname.snp.makeConstraints { make in
            make.top.equalTo(changeAvatarButton.snp.bottom).offset(10)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(50)
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(userNickname.snp.bottom).offset(20)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.height.equalTo(35)
        }
    }

}
