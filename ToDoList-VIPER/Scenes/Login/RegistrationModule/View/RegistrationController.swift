//
//  RegistrationController.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 07.03.2024.
//

import UIKit
import SnapKit

final class RegistrationController: SingInController {
    var presenter: RegistrationPresenterPtorocol?
    
    //MARK: - OUTLETS
    private lazy var image: UIImageView = {
        let imageView = UIImageView()
        let picture = UIImage(named: "registerImage")
        imageView.image = picture
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var createNewUserLabel: UILabel = {
        let label = UILabel()
        label.text = "Создайте аккаунт"
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textColor = .systemCyan
        return label
    }()

    private lazy var nameField = SignInTextField(placeholder: "Имя",
                                                 nameOfImage: "person.fill",
                                                 tag: 0,
                                                 delegate: self,
                                                 capitalizationType: .words,
                                                 returnKey: .continue,
                                                 secure: false)
    private lazy var emailField = SignInTextField(placeholder: "Email адресс",
                                                  nameOfImage: "at.circle.fill",
                                                  tag: 1,
                                                  delegate: self,
                                                  capitalizationType: .none,
                                                  returnKey: .continue,
                                                  secure: false)
    private lazy var passwordField = SignInTextField(placeholder: "Пароль",
                                                     nameOfImage: "lock.fill",
                                                     tag: 2,
                                                     delegate: self,
                                                     capitalizationType: .none,
                                                     returnKey: .done,
                                                     secure: false)
    
    private lazy var registerButton = LoadingButton(originalText: "Зарегистрироваться", type: .system)
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupTextFieldBorders()
    }
    
    //MARK: - Setup Hierarchy
    override func setupHierarchy() {
        super.setupHierarchy()
        scrollView.addSubview(image)
        scrollView.addSubview(createNewUserLabel)
        scrollView.addSubview(nameField)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(registerButton)
    }

    //MARK: - Setup Layout
    override func setupLayout() {
        super.setupLayout()
        image.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top).offset(20)
            make.centerX.equalTo(scrollView.safeAreaLayoutGuide.snp.centerX)
            make.height.equalTo(view.frame.size.height / 3)
            make.width.equalTo(view.frame.size.width * 0.5)
        }
        
        createNewUserLabel.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(20)
            make.centerX.equalTo(scrollView.safeAreaLayoutGuide.snp.centerX)
        }
        
        nameField.snp.makeConstraints { make in
            make.top.equalTo(createNewUserLabel.snp.bottom).offset(30)
            make.leading.trailing.equalTo(scrollView.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(45)

        }
        
        emailField.snp.makeConstraints { make in
            make.top.equalTo(nameField.snp.bottom).offset(10)
            make.leading.trailing.equalTo(scrollView.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(45)
        }
        
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(emailField.snp.bottom).offset(10)
            make.leading.trailing.equalTo(scrollView.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(45)
        }
        
        registerButton.snp.makeConstraints { make in
//            make.top.equalTo(passwordField.snp.bottom).offset(70)
            make.bottom.equalTo(scrollView.safeAreaLayoutGuide.snp.bottom).inset(50)
            make.leading.trailing.equalTo(scrollView.safeAreaLayoutGuide).inset(35)
        }
    }
    //MARK: - Outlets Configuration
    private func setupTextFieldBorders() {
        nameField.addBottomLine(width: 1.5, color: .systemGray3)
        emailField.addBottomLine(width: 1.5, color: .systemGray3)
        passwordField.addBottomLine(width: 1.5, color: .systemGray3)
    }
    
    private func setupButton() {
        registerButton.addTarget(self, action: #selector(registerNewUser), for: .touchDown)
    }
    //MARK: - Button's Action
    @objc func registerNewUser() {
        if (nameField.text != nil) && (emailField.text != nil) && (passwordField.text != nil) {
            let name = nameField.text ?? "Temp"
            let email = emailField.text ?? ""
            let password = passwordField.text ?? ""
            self.registerButton.showLoading()
            presenter?.registerNewUser(with: name, email: email, password: password)
        }
    }
}
    //MARK: - RegistrationViewProtocol Extension
extension RegistrationController: RegistrationViewProtocol {
    func stopAnimateRegisterButton() {
        self.registerButton.hideLoading()
    }
}
