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
    private lazy var scrollView: UIScrollView = {
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
        label.textColor = .systemCyan
        return label
    }()
    
    private lazy var nameField = UITextField.createBasicTextField(textSize: 14, weight: .semibold, borderStyle: .roundedRect, returnKey: .continue, tag: 0)
    private lazy var emailField = UITextField.createBasicTextField(textSize: 14, weight: .semibold, borderStyle: .roundedRect, returnKey: .continue, tag: 1)
    private lazy var passwordField = UITextField.createBasicTextField(textSize: 14, weight: .semibold, borderStyle: .roundedRect, returnKey: .done, tag: 2)
    
    private lazy var registerButton: LoadingButton = {
        let button = LoadingButton(type: .system)
        button.originalButtonText = "Зарегистироваться"
        button.tintColor = .systemBackground
        button.backgroundColor = .systemCyan
        button.hideLoading()
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(registerNewUser), for: .touchDown)
        return button
    }()
    
    //MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 200)
        subscribeKeyboardEvents()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        scrollView.keyboardDismissMode = .interactive
        setupHierarcy()
        setupElemenets()
        setupLayout()
//        let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
//        print(appDelegate.window?.rootViewController)
//        let allScenes = UIApplication.shared.connectedScenes
//        let scene = allScenes.first { $0.activationState == .foregroundActive }
//        if let sceneWindow = scene as? UIWindowScene {
//            print(sceneWindow.keyWindow?.rootViewController)
//        }
//
    }
    
    deinit {
        print("RegistrationController is ☠️")
    }
    
    //MARK: - Setup Elements
    private func setupHierarcy() {
        view.addSubview(scrollView)
        scrollView.addSubview(image)
        scrollView.addSubview(createNewUserLabel)
        scrollView.addSubview(nameField)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(registerButton)
    }
    
    private func setupLayout() {
        scrollView.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
            make.centerY.equalTo(view.safeAreaLayoutGuide.snp.centerY)
            make.width.equalTo(view.snp.width)
            make.height.equalTo(view.snp.height)
        }
        
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
            make.top.equalTo(passwordField.snp.bottom).offset(100)
            make.leading.trailing.equalTo(scrollView.safeAreaLayoutGuide).inset(35)
            make.height.equalTo(45)
        }
    }
    
    private func setupElemenets() {
        nameField.placeholder = "Имя"
        emailField.placeholder = "Email адресс"
        passwordField.placeholder = "Пароль"
        nameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
    }
    
    //MARK: - ScrollView Keyboard function
    func subscribeKeyboardEvents() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        guard let ks = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        DispatchQueue.main.async {
            self.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom:  ks.height - self.view.safeAreaInsets.bottom + 180, right: 0)
        }
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        scrollView.contentInset = .zero
    }
    
    //MARK: - Button Action
    @objc func registerNewUser() {
        switch (nameField.text != nil) && (emailField.text != nil) && (passwordField.text != nil) {
        case nameField.text == "" || emailField.text == "" || passwordField.text == "":
            presenter?.showAllert(status: .emptyFields)
        case emailField.text?.isValidEmail() == false:
            presenter?.showAllert(status: .notValidEmail)
        default:
            let name = nameField.text ?? "Temp"
            let email = emailField.text ?? ""
            let password = passwordField.text ?? ""
            self.registerButton.showLoading()
            presenter?.registerNewUser(with: name, email: email, password: password)
        }
    }
}

extension RegistrationController: UITextFieldDelegate {
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
