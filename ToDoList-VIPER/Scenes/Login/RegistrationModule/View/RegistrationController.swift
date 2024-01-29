//
//  RegistrationController.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 29.01.2024.
//

import UIKit
import SnapKit

final class RegistrationController: UIViewController, RegistrationViewProtocol {
    var presenter: RegistrationPresenterPtorocol?
    //MARK: - Outlets
    private lazy var containerView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var image: UIImageView = {
        let imageView = UIImageView()
        let picture = UIImage(named: "registerImage")
        imageView.image = picture
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var createNewUserLabel: UILabel = {
        let label = UILabel()
        label.text = "Создайте аккаунт"
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        return label
    }()
    
    private lazy var nameField = UITextField.createBasicTextField(textSize: 14, weight: .semibold, borderStyle: .roundedRect)
    private lazy var emailField = UITextField.createBasicTextField(textSize: 14, weight: .semibold, borderStyle: .roundedRect)
    private lazy var passwordField = UITextField.createBasicTextField(textSize: 14, weight: .semibold, borderStyle: .roundedRect)
    private lazy var registerButton = UIButton.createToDoButton(title: "Зарегестироваться", backColor: .systemBlue, tintColor: .systemBackground)
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        registerButton.addTarget(self, action: #selector(registerNewUser), for: .touchDown)
        setupHierarcy()
        setupLayout()
        
    }
    
    //MARK: - Setup Elements
    private func setupHierarcy() {
        view.addSubview(containerView)
        containerView.addSubview(image)
        containerView.addSubview(createNewUserLabel)
        containerView.addSubview(nameField)
        containerView.addSubview(emailField)
        containerView.addSubview(passwordField)
        containerView.addSubview(registerButton)
    }
    
    private func setupLayout() {
        containerView.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
            make.centerY.equalTo(view.safeAreaLayoutGuide.snp.centerY)
            make.width.equalTo(view.snp.width)
            make.height.equalTo(view.snp.height)
        }
        
        image.snp.makeConstraints { make in
            make.top.equalTo(containerView.safeAreaLayoutGuide.snp.top).offset(20)
            make.centerX.equalTo(containerView.safeAreaLayoutGuide.snp.centerX)
            make.height.equalTo(view.bounds.size.height / 2.5)
            make.width.equalTo(view.bounds.size.width / 1.5)
        }
        
        createNewUserLabel.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(20)
            make.centerX.equalTo(containerView.safeAreaLayoutGuide.snp.centerX)
        }
        
        nameField.snp.makeConstraints { make in
            make.top.equalTo(createNewUserLabel.snp.bottom).offset(30)
            make.leading.trailing.equalTo(containerView.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(35)
        }
        
        emailField.snp.makeConstraints { make in
            make.top.equalTo(nameField.snp.bottom).offset(10)
            make.leading.trailing.equalTo(containerView.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(35)
        }
        
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(emailField.snp.bottom).offset(10)
            make.leading.trailing.equalTo(containerView.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(35)
        }
        
        registerButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(50)
            make.leading.trailing.equalTo(containerView.safeAreaLayoutGuide).inset(35)
            make.height.equalTo(40)
        }
    }
    
    //MARK: - Button Action
    @objc func registerNewUser() {
        if let name = nameField.text,
           let email = emailField.text,
           let password = passwordField.text {
            presenter?.registerNewUser(with: name, email: email, password: password)
        } else {
            presenter?.showAllert(status: .emptyFields)
        }
        
    }
}
