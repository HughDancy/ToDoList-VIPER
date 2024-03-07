//
//  SecondLoginController.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 29.02.2024.
//

import UIKit
import SnapKit

final class LoginController: SingInController {
    var presenter: LoginPresenterProtocol?
    
    //MARK: - OUTLETS
    private lazy var logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "loadingAnimate")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var loginField = SignInTextField(placeholder: "Логин",
                                                  nameOfImage: "at",
                                                  tag: 0,
                                                  delegate: self,
                                                  frame: .zero,
                                                  capitalizationType: .none,
                                                  returnKey: .next,
                                                  secure: false)
    
    private lazy var passwordField = SignInTextField(placeholder: "Пароль",
                                                     nameOfImage: "lock",
                                                     tag: 1,
                                                     delegate: self,
                                                     frame: .zero,
                                                     capitalizationType: .none,
                                                     returnKey: .done,
                                                     secure: true)
    
    private lazy var loginButton = LoadingButton(originalText: "Войти", type: .custom)
    
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Зарегестрироваться", for: .normal)
        button.backgroundColor = .systemBackground
        button.tintColor = .systemCyan
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(registerUser), for: .touchDown)
        return button
    }()
    
    private lazy var orLabel: UILabel = {
        let label = UILabel()
        label.text = "или войти с помощью"
        label.textColor = .systemGray2
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    private lazy var googleLoginButton = CircleBaseButton(imageName: "googleLogo", color: .systemFill, cornerRadius: 30)
    private lazy var appleLoginButton = CircleBaseButton(imageName: "apple.logo", color: .systemFill, cornerRadius: 30)
    
    private lazy var sigInButtonStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 15
        return stack
    }()
    
    //MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.changeState()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layoutIfNeeded()
        setupButtons()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupTextFieldsBorder()
    }
    
    //MARK: - Setup Hierarchy
    override func setupHierarchy() {
        super.setupHierarchy()
        scrollView.addSubview(logoImage)
        scrollView.addSubview(loginField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(loginButton)
        scrollView.addSubview(registerButton)
        scrollView.addSubview(orLabel)
        scrollView.addSubview(sigInButtonStack)
        sigInButtonStack.addArrangedSubview(googleLoginButton)
        sigInButtonStack.addArrangedSubview(appleLoginButton)
//        scrollView.addSubview(googleLoginButton)
//        scrollView.addSubview(appleLoginButton)
    }
    
    //MARK: - Setup Layout
    override func setupLayout() {
        super.setupLayout()
        logoImage.snp.makeConstraints { make in
//            make.top.equalTo(scrollView.snp.top).offset(50)
//            make.top.equalTo(scrollView.snp.top).offset(UIScreen.main.bounds.height / 6).priority(1000)

//            make.top.equalTo(scrollView.snp.top).offset(UIScreen.main.bounds.width / 2)
//            make.top.equalTo(view.snp.top).offset((UIScreen.main.bounds.height / 3))
            make.top.equalToSuperview().offset(scrollView.bounds.height - scrollView.bounds.width)
            print(UIScreen.main.bounds.height)
            print(UIScreen.main.bounds.width)
            print(view.bounds.height)
            print(view.bounds.width)
            
//            make.top.equalToSuperview().multipliedBy(0.1)
            make.centerX.equalTo(scrollView.snp.centerX)
            make.height.equalTo(UIScreen.main.bounds.height / 4)
            make.width.equalTo(UIScreen.main.bounds.height * 0.5)
        }
        
        loginField.snp.makeConstraints { make in
            make.top.equalTo(logoImage.snp.bottom).offset(10)
            make.leading.trailing.equalTo(scrollView.safeAreaLayoutGuide).inset(40)
            make.height.equalTo(40)
        }
        
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(loginField.snp.bottom).offset(15)
            make.leading.trailing.equalTo(scrollView.safeAreaLayoutGuide).inset(40)
            make.height.equalTo(40)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(20)
            make.leading.trailing.equalTo(scrollView.safeAreaLayoutGuide).inset(40)
//            make.height.equalTo(UIScreen.main.bounds.size.width / 8)
        }
        
        orLabel.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(20)
            make.centerX.equalTo(scrollView.snp.centerX)
        }
        
        sigInButtonStack.snp.makeConstraints { make in
            make.top.equalTo(orLabel.snp.bottom).offset(15)
            make.centerX.equalTo(scrollView.safeAreaLayoutGuide.snp.centerX)
        }
        
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(sigInButtonStack.snp.bottom).offset(5)
            make.leading.trailing.equalTo(scrollView.safeAreaLayoutGuide).inset(40)
            make.height.equalTo(35)
        }
    }
    
    //MARK: - Setup Outlets
    private func setupTextFieldsBorder() {
        loginField.addBottomLine(width: 1.5, color: .systemGray3)
        passwordField.addBottomLine(width: 1.5, color: .systemGray3)
    }
    
    private func setupButtons() {
        loginButton.addTarget(self, action: #selector(loginApp), for: .touchDown)
        registerButton.addTarget(self, action: #selector(registerUser), for: .touchDown)
        googleLoginButton.addTarget(self, action: #selector(googleLogin), for: .touchDown)
        appleLoginButton.addTarget(self, action: #selector(appleLogIn), for: .touchDown)
    }
    
    //MARK: - Buttons action
    @objc func loginApp()  {
        self.view.endEditing(true)
        self.loginButton.showLoading()
        presenter?.chekTheLogin(login: loginField.text, password: passwordField.text)
    }
    
    @objc func registerUser() {
        presenter?.goToRegistration()
    }
    
    @objc func googleLogin() {
        presenter?.googleSingIn()
    }
    
    @objc func appleLogIn() {
        presenter?.appleSignIn()
        print("You login with Apple")
    }
}

extension LoginController: LoginViewProtocol {
    func makeAnimateTextField(with state: LogInStatus) {
        if state == .emptyLogin {
            let animation = CABasicAnimation.createShakeAnimation(for: loginField, keyPath: "position")
            loginField.layer.add(animation, forKey: "position")
        } else if state == .emptyPassword {
            let animation = CABasicAnimation.createShakeAnimation(for: passwordField, keyPath: "position")
            passwordField.layer.add(animation, forKey: "position")
        }
    }
    
    func stopAnimateLoginButton() {
        self.loginButton.hideLoading()
    }
}
