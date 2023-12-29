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
        button.addTarget(self, action: #selector(presentPicker), for: .touchDown)
        return button
    }()
    
    private lazy var userNickname: UITextField = {
       let nickname = UITextField()
        nickname.placeholder = "User name"
        nickname.borderStyle = .roundedRect
        nickname.backgroundColor = .systemGray6
        nickname.delegate = self
        nickname.returnKeyType = .done
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
        button.addTarget(self, action: #selector(saveChanges), for: .touchDown)
        return button
    }()
    
    private lazy var imagePicker: UIImagePickerController = {
       let imagePicker = UIImagePickerController()

        
        return imagePicker
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
    
    @objc func saveChanges() {
        if userNickname.text != nil && userNickname.text != "" {
            ToDoUserDefaults.shares.nickname = userNickname.text ?? ""
        }
        self.dismiss(animated: true)
    }
    
    @objc func presentPicker() {
        let alertSheet = UIAlertController(title: "Choose the source", message: nil, preferredStyle: .alert)
        var picker = UIImagePickerController()
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    var imagePicker = UIImagePickerController()
                    imagePicker.delegate = self
                    imagePicker.sourceType = .camera;
                    imagePicker.allowsEditing = false
                    self.present(imagePicker, animated: true, completion: nil)
                }
        }
        
        let libraryAction = UIAlertAction(title: "Media Library", style: .default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                    var imagePicker = UIImagePickerController()
                    imagePicker.delegate = self
                    imagePicker.sourceType = .photoLibrary;
                    imagePicker.allowsEditing = false
                    self.present(imagePicker, animated: true, completion: nil)
                }
          
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertSheet.addAction(cameraAction)
        alertSheet.addAction(libraryAction)
        alertSheet.addAction(cancelAction)
        self.present(alertSheet, animated: true)
//        self.present(imagePicker, animated: true)
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

extension UserOptionsController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
}
