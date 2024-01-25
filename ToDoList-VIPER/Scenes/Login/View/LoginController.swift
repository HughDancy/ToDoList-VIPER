//
//  LoginController.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 25.01.2024.
//

import UIKit
import SnapKit

class LoginController: UIViewController, LoginViewProtocol {
    var presenter: LoginPresenterProtocol?
    
    //MARK: - Outlets
    private lazy var logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "loadingAnimate")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var loginField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Логин"
        textField.tintColor = .systemGray4
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftView = view
        textField.leftViewMode = .always
        
        return textField
    }()
    
    private lazy var passwordField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Пароль"
        textField.tintColor = .systemGray4
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftView = view
        textField.leftViewMode = .always
    
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Войти", for: .normal)
        button.tintColor = .systemBackground
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        
        return button
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Зарегестрироваться", for: .normal)
        button.tintColor = .systemBackground
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        
        return button
    }()
    
    private lazy var orLabel: UILabel = {
        let label = UILabel()
        label.text = "Или"
        label.textColor = .systemGray4
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    private lazy var googleLoginButton: UIButton = {
        let button = UIButton(type: .system)
//        button.setImage(UIImage(named: "googleLogo"), for: .normal)
        button.setTitle("Войти через Google", for: .normal)
        button.backgroundColor = .systemGray6
        button.tintColor = .systemGray3
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupHierarchy()
        setupLayout()
        
    }
    
    //MARK: - Setup Outlets
    private func setupHierarchy() {
        view.addSubview(logoImage)
        view.addSubview(loginField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(registerButton)
        view.addSubview(orLabel)
        view.addSubview(googleLoginButton)
    }
    
    private func setupLayout() {
        logoImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
            make.height.equalTo(view.frame.size.height / 3)
            make.width.equalTo(view.frame.size.width * 0.5)
        }
        
        loginField.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide.snp.centerX).offset(10)
            make.top.equalTo(logoImage.snp.bottom).offset(10)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(40)
        }
        
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(loginField.snp.bottom).offset(15)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(40)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(40)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.height.equalTo(35)
        }
        
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(10)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.height.equalTo(35)
        }
        
        orLabel.snp.makeConstraints { make in
            make.top.equalTo(registerButton.snp.bottom).offset(15)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
        }
        
        googleLoginButton.snp.makeConstraints { make in
            make.top.equalTo(orLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.height.equalTo(35)
        }
    }
    
    //MARK: - Buttons action
    @objc func loginApp()  {
        print("Log In")
    }
    
    @objc func registerUser() {
        print("Register new user")
    }
    
    @objc func googleLogin() {
        print("You login with Google")
    }
    
    
    
}
