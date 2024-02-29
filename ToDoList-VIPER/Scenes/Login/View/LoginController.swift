//
//  LoginController.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 25.01.2024.
//

import UIKit
import SnapKit

final class LoginController: UIViewController, LoginViewProtocol {
    var presenter: LoginPresenterProtocol?
    
    //MARK: - Outlets
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "loadingAnimate")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var loginField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.placeholder = "Логин"
        textField.tintColor = .systemGray4
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftView = view
        textField.leftViewMode = .always
        textField.autocapitalizationType = .none
        textField.returnKeyType = .next
        textField.tag = 0
        textField.delegate = self
        return textField
    }()
    
    private lazy var passwordField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.placeholder = "Пароль"
        textField.tintColor = .systemGray4
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftView = view
        textField.leftViewMode = .always
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.returnKeyType = .done
        textField.tag = 1
        textField.delegate = self
        return textField
    }()
    
    private lazy var loginButton: LoadingButton = {
        let button = LoadingButton(type: .system)
        button.originalButtonText = "Войти"
        button.tintColor = .systemBackground
        button.backgroundColor = .systemCyan
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.hideLoading()
        button.addTarget(self, action: #selector(loginApp), for: .touchDown)
        
        return button
    }()
    
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
    
    private lazy var googleLoginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Войти через Google", for: .normal)
        button.tintColor = .systemBackground
        button.backgroundColor = .systemGray3
        button.addTarget(self, action: #selector(googleLogin), for: .touchDown)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var appleLoginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Войти через Apple", for: .normal)
        button.tintColor = .systemBackground
        button.backgroundColor = .systemGray3
        button.addTarget(self, action: #selector(appleLogIn), for: .touchDown)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var googleImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "googleLogo"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var appleImage: UIImageView = {
       let imageView = UIImageView(image: UIImage(systemName: "apple.logo"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    //MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 200)
        subscribeKeyboardEvents()
        presenter?.changeState()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        scrollView.keyboardDismissMode = .interactive
        setupHierarchy()
        setupLayout()
        view.layoutIfNeeded()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupTextFieldsBorder()
    }
    
    deinit {
        print("LoginController is ☠️")
    }
    
    //MARK: - Setup Hierarchy
    private func setupHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(logoImage)
        scrollView.addSubview(loginField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(loginButton)
        scrollView.addSubview(registerButton)
        scrollView.addSubview(orLabel)
        googleLoginButton.addSubview(googleImage)
        scrollView.addSubview(googleLoginButton)
        appleLoginButton.addSubview(appleImage)
        scrollView.addSubview(appleLoginButton)
    }

    //MARK: - Setup Layout
    private func setupLayout() {
        scrollView.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
            make.centerY.equalTo(view.safeAreaLayoutGuide.snp.centerY)
            make.width.equalTo(view.snp.width)
            make.height.equalTo(view.snp.height)
        }
        
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
            make.top.equalTo(passwordField.snp.bottom).offset(40)
            make.leading.trailing.equalTo(scrollView.safeAreaLayoutGuide).inset(40)
            make.height.equalTo(40)
        }
        
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(10)
            make.leading.trailing.equalTo(scrollView.safeAreaLayoutGuide).inset(40)
            make.height.equalTo(35)
        }
        
        orLabel.snp.makeConstraints { make in
            make.top.equalTo(registerButton.snp.bottom).offset(15)
            make.centerX.equalTo(scrollView.snp.centerX)
        }

        googleLoginButton.snp.makeConstraints { make in
            make.top.equalTo(orLabel.snp.bottom).offset(10)
            make.centerX.equalTo(scrollView.snp.centerX)
            make.leading.trailing.equalTo(scrollView.safeAreaLayoutGuide).inset(40)
            make.height.equalTo(40)
        }
        
        googleImage.snp.makeConstraints { make in
            make.top.leading.bottom.equalTo(googleLoginButton.safeAreaLayoutGuide).inset(10)
        }
        
        appleLoginButton.snp.makeConstraints { make in
            make.top.equalTo(googleLoginButton.snp.bottom).offset(10)
            make.centerX.equalTo(scrollView.safeAreaLayoutGuide.snp.centerX)
            make.leading.trailing.equalTo(scrollView.safeAreaLayoutGuide).inset(40)
            make.height.equalTo(40)
        }
        
        appleImage.snp.makeConstraints { make in
            make.top.bottom.equalTo(appleLoginButton.safeAreaLayoutGuide).inset(10)
            make.leading.equalTo(appleLoginButton.safeAreaLayoutGuide.snp.leading).offset(25)
        }
    }
    
    //MARK: - Setup textfields border
    private func setupTextFieldsBorder() {
        loginField.addBottomLine(width: 1.5, color: .systemGray3)
        passwordField.addBottomLine(width: 1.5, color: .systemGray3)
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
    
    //MARK: - ScrollView keyboard functions
    func subscribeKeyboardEvents() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        guard let ks = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        DispatchQueue.main.async {
            self.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom:  ks.height - self.view.safeAreaInsets.bottom + 110, right: 0)
        }
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        scrollView.contentInset = .zero
    }
}

//MARK: - TextField Delegate
extension LoginController: UITextFieldDelegate {
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

