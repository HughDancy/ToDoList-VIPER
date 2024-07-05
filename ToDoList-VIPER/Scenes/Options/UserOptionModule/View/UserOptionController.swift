//
//  UserOptionController.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 05.07.2024.
//

import UIKit

final class UserOptionController: UIViewController {
    var presenter: UserOptionPresenterProtocol?
    private var userData: (String, URL?) = ("Temp", nil)
    
    //MARK: - Outlets
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Назад", for: .normal)
        button.tintColor = .systemBackground
        button.backgroundColor = .systemCyan
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(goBack), for: .touchDown)
        return button
    }()
    
    
    private lazy var userAvatar: UIImageView = {
       let imageView = UIImageView()
        imageView.layer.cornerRadius = UserOptionsSizes.avatar.value / 2
        imageView.clipsToBounds = true
        imageView.kf.setImage(with: userData.1,
                              placeholder: UIImage(named: "mockUser_3"),
                              options: [
                                .cacheOriginalImage
                              ])
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var userNameField: UITextField = {
       let textField = UITextField()
        textField.text = userData.0
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var saveChangeButton: UIButton = {
       let button = UIButton()
        button.setTitle("Сохранить изменения", for: .normal)
        button.tintColor = .systemBackground
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(saveChanges), for: .touchDown)
        return button
    }()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.retriveData()
        view.backgroundColor = .systemBackground
        view.overrideUserInterfaceStyle = ToDoUserDefaults.shares.theme.getUserInterfaceStyle()
        self.setupView()
  
    }
    
    private func setupView() {
        setupHierarchy()
        setupLayout()
        navigationItem.backBarButtonItem?.isHidden = true
        userAvatar.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(chooseAvatar)))
    }
    
    //MARK: - Setup Hierarchy
    private func setupHierarchy() {
//        view.addSubview(backButton)
        view.addSubview(userAvatar)
        view.addSubview(userNameField)
        view.addSubview(saveChangeButton)
    }
    
    //MARK: - Setup Layout
    private func setupLayout() {
//        backButton.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(25)
//            make.leading.equalToSuperview().offset(20)
//            make.height.equalTo(40)
//            make.width.equalTo(50)
//        }
//        
        userAvatar.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.width.equalTo(UserOptionsSizes.avatar.value)
        }
        
        userNameField.snp.makeConstraints { make in
            make.top.equalTo(userAvatar.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(35)
            make.height.equalTo(40)
        }
        
        saveChangeButton.snp.makeConstraints { make in
            make.top.equalTo(userNameField.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalTo(45)
        }
    }
    
    
    //MARK: - Button's action
    @objc func goBack() {
        
    }
    
    @objc func saveChanges() {
        guard let name = userNameField.text else { return }
        presenter?.saveUserInfo(name: name)
    }
    
    @objc func chooseAvatar() {
        self.presenter?.chooseAvatar()
    }

}

extension UserOptionController: UserOptionViewProtocol {
    func getUserData(_ data: (String, URL?)) {
        self.userData = data
    }
}


extension UserOptionController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            presenter?.setImage(self.userAvatar.image ?? UIImage(named: "mockUser_3")!)
            return
        }
        self.userAvatar.image = image
        presenter?.setImage(image)
    }
}

fileprivate enum UserOptionsSizes: CGFloat {
    case avatar = 300
    
    var value: CGFloat {
        switch self {
        case .avatar:
            UIScreen.main.bounds.height > 700 ? rawValue : 200
        }
    }
}
