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
        imageView.layer.cornerRadius = 300 / 2
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "testAva")
        imageView.layer.shadowOffset = CGSizeMake(10, 10)
        imageView.layer.shadowOpacity = 0.7
        imageView.layer.shadowRadius = 5
        imageView.layer.shadowColor = UIColor.systemGray.cgColor
        
        return imageView
    }()
    
    private lazy var avatarShadowView: UIView = {
        let view = UIView()

        view.layer.masksToBounds = false
        view.layer.cornerRadius = view.frame.height/2
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: view.layer.cornerRadius).cgPath
        view.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        view.layer.shadowOpacity = 0.7
//        view.layer.shadowRadius = 7
        return view
    }()
    
    private lazy var changeAvatarButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Редактировать", for: .normal)
        button.backgroundColor = .clear
        button.tintColor = .systemBlue
        return button
    }()
    
    private lazy var userNickname: UITextField = {
       let nickname = UITextField()
        nickname.placeholder = "User name"
        nickname.borderStyle = .roundedRect
        nickname.backgroundColor = .systemGray6
        nickname.delegate = self
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
        navigationController?.navigationBar.tintColor = .systemGray
        setupHierarchy()
        setupLayout()
    }
    

    //MARK: - Setup Elements
    private func setupHierarchy() {
        view.addSubview(avatarShadowView)
        view.addSubview(avatarImage)
        view.addSubview(changeAvatarButton)
        view.addSubview(userNickname)
        view.addSubview(saveButton)
    }
    
    private func setupLayout() {
        avatarShadowView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
            make.height.width.equalTo(300)
        }
        
        avatarImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
            make.height.width.equalTo(300)
        }
        
        changeAvatarButton.snp.makeConstraints { make in
            make.top.equalTo(avatarImage.snp.bottom).offset(10)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(55)
            make.height.equalTo(35)
        }
        
        userNickname.snp.makeConstraints { make in
            make.top.equalTo(changeAvatarButton.snp.bottom).offset(20)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(55)
            make.height.equalTo(45)
        }
        
        saveButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(30)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.height.equalTo(35)
        }
    }
}

//MARK: - TextField Delegate
extension UserOptionsController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1

        if let nextResponder = self.view.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
