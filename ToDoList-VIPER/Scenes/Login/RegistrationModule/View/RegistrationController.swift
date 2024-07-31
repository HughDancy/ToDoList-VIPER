//
//  RegistrationController.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 07.03.2024.
//

import UIKit

final class RegistrationController: SingInController {
    var presenter: RegistrationPresenterPtorocol?
    
    //MARK: - OUTLETS
    private lazy var createNewUserLabel = UILabel.createSimpleLabel(text: "Создайте аккаунт", 
                                                                    size: 25,
                                                                    width: .semibold,
                                                                    color: .systemCyan,
                                                                    aligment: .center,
                                                                    numberLines: 1)

    private lazy var image: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: MockUsersAvatrs.collection.randomElement()?.imageName ?? "mockUser_1")
        imageView.layer.cornerRadius = RegistrationSizes.imageSize.value / 2
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var choosePictureLabel: UIButton = {
        let button = UIButton(type: .system)
        let titleFont = UIFont.systemFont(ofSize: RegistrationSizes.avatarFontSize.value, weight: .medium)
        let attributes: [NSAttributedString.Key: Any] = [
                   .font: titleFont
               ]
        let atributeTitle = NSAttributedString(string: "Выберете фото", attributes: attributes)
        button.setAttributedTitle(atributeTitle, for: .normal)
        button.backgroundColor = .systemBackground
        button.tintColor = .systemCyan
        button.addTarget(self, action: #selector(chooseSource), for: .touchDown)
        
        return button
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
        scrollView.addSubview(createNewUserLabel)
        scrollView.addSubview(image)
        scrollView.addSubview(choosePictureLabel)
        scrollView.addSubview(nameField)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(registerButton)
    }
    
    //MARK: - Setup Layout
    override func setupLayout() {
        super.setupLayout()
        createNewUserLabel.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top).offset(20)
            make.centerX.equalTo(scrollView.safeAreaLayoutGuide.snp.centerX)
        }
        
        image.snp.makeConstraints { make in
            make.top.equalTo(createNewUserLabel.snp.bottom).offset(15)
            make.centerX.equalTo(scrollView.safeAreaLayoutGuide.snp.centerX)
            make.height.width.equalTo(RegistrationSizes.imageSize.value)
        }
        
        choosePictureLabel.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(10)
            make.centerX.equalTo(scrollView.snp.centerX)
            make.height.equalTo(RegistrationSizes.avatarFontSize.value)
        }
        
        nameField.snp.makeConstraints { make in
            make.top.equalTo(choosePictureLabel.snp.bottom).offset(30)
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
        self.image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(chooseSource)))
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
    
    @objc func chooseSource() {
        presenter?.chooseImageSource()
    }
}
     //MARK: - RegistrationViewProtocol Extension
extension RegistrationController: RegistrationViewProtocol {
    func stopAnimateRegisterButton() {
        self.registerButton.hideLoading()
    }
}

    //MARK: - ImagePicker and UINavigationController Extension
extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            presenter?.setImage(self.image.image ?? UIImage(named: "mockUser_3")!)
            return
        }
        self.image.image = image
        presenter?.setImage(image)
    }
}

fileprivate enum RegistrationSizes: CGFloat {
    case imageSize = 300
    case avatarFontSize = 20
    
    var value: CGFloat {
        switch self {
        case .imageSize:
            UIScreen.main.bounds.height > 700 ? rawValue : 200
        case .avatarFontSize:
            UIScreen.main.bounds.height > 700 ? rawValue : 15
        }
    }
}
