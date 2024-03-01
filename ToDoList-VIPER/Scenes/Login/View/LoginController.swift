//
//  SecondLoginController.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 29.02.2024.
//

import UIKit
import SnapKit

final class LoginController: SingInController, LoginViewProtocol {
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
        label.text = "или"
        label.textColor = .systemGray2
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        return label
    }()

    private lazy var googleLoginButton = BaseButton(imageName: "googleLogo", text: "Войти через Google", color: .systemGray3)
    private lazy var appleLoginButton = BaseButton(imageName: "apple.logo", text: "Войти через Apple", color: .systemGray3)

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
        scrollView.addSubview(googleLoginButton)
        scrollView.addSubview(appleLoginButton)
    }
    
    //MARK: - Setup Layout
    override func setupLayout() {
        super.setupLayout()
        logoImage.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top).offset(50)
            make.centerX.equalTo(scrollView.snp.centerX)
            make.height.equalTo(view.frame.size.height / 3)
            make.width.equalTo(view.frame.size.width * 0.5)
        }
        
        loginField.snp.makeConstraints { make in
            make.top.equalTo(logoImage.snp.bottom).offset(10)
            make.leading.trailing.equalTo(scrollView.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(40)
        }
        
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(loginField.snp.bottom).offset(15)
            make.leading.trailing.equalTo(scrollView.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(40)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(20)
            make.leading.trailing.equalTo(scrollView.safeAreaLayoutGuide).inset(40)
            make.height.equalTo(UIScreen.main.bounds.size.width / 10)
        }
        
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(5)
            make.leading.trailing.equalTo(scrollView.safeAreaLayoutGuide).inset(40)
            make.height.equalTo(35)
        }
        
        orLabel.snp.makeConstraints { make in
            make.top.equalTo(registerButton.snp.bottom).offset(5)
            make.centerX.equalTo(scrollView.snp.centerX)
        }

        googleLoginButton.snp.makeConstraints { make in
            make.top.equalTo(orLabel.snp.bottom).offset(10)
            make.centerX.equalTo(scrollView.snp.centerX)
            make.leading.trailing.equalTo(scrollView.safeAreaLayoutGuide).inset(40)
            make.height.equalTo(UIScreen.main.bounds.size.width / 10)
        }
        
        appleLoginButton.snp.makeConstraints { make in
            make.top.equalTo(googleLoginButton.snp.bottom).offset(10)
            make.centerX.equalTo(scrollView.safeAreaLayoutGuide.snp.centerX)
            make.leading.trailing.equalTo(scrollView.safeAreaLayoutGuide).inset(40)
            make.height.equalTo(UIScreen.main.bounds.size.width / 10)
        }
    }
    
    //MARK: - Setup Outlets
    private func setupTextFieldsBorder() {
        loginField.addBottomLine(width: 1.5, color: .systemGray3)
        passwordField.addBottomLine(width: 1.5, color: .systemGray3)
    }
    
    private func setupButtons() {
        loginButton.addTarget(self, action: #selector(loginApp), for: .touchDown)
    }
    
    //MARK: - Buttons action
    @objc func loginApp()  {
        self.view.endEditing(true)
        switch (loginField.text != nil) && (passwordField.text != nil) {
          case (loginField.text == "") || (passwordField.text == ""):
            if loginField.text == "" {
                let animation = CABasicAnimation.createShakeAnimation(for: loginField, keyPath: "position")
                loginField.layer.add(animation, forKey: "position")
            } else {
                let animation = CABasicAnimation.createShakeAnimation(for: passwordField, keyPath: "position")
                passwordField.layer.add(animation, forKey: "position")
            }
        case loginField.text?.isValidEmail() == false:
            print("Введен неверный email")
        default:
            self.loginButton.showLoading()
            presenter?.chekTheLogin(login: loginField.text ?? "", password: passwordField.text ?? "")
        }
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
