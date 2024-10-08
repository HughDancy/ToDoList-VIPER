//
//  UserOptionController.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 05.07.2024.
//

import UIKit

final class UserOptionController: UIViewController {
    var presenter: UserOptionPresenterProtocol?
    private var userName: String = ""
    private var userAvatarUrl: URL?

    // MARK: - Outlets
    private lazy var userAvatar: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = UserOptionsSizes.avatar.value / 2
        imageView.clipsToBounds = true
        imageView.kf.setImage(with: userAvatarUrl,
                              placeholder: UIImage(named: "mockUser_3"),
                              options: [
                                .cacheOriginalImage
                              ])
        imageView.isUserInteractionEnabled = true
        return imageView
    }()

    private lazy var userNameField: UITextField = {
        let textField = UITextField()
        textField.text = userName
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

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.retriveData()
        view.backgroundColor = .systemBackground
        view.overrideUserInterfaceStyle = ToDoThemeDefaults.shared.theme.getUserInterfaceStyle()
        self.setupView()
    }

    deinit {
        debugPrint("? deinit \(self)")
    }

    private func setupView() {
        setupHierarchy()
        setupLayout()
        userNameField.delegate = self
        self.tabBarController?.tabBar.isHidden = true
        userAvatar.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(chooseAvatar)))
    }

    // MARK: - Setup Hierarchy
    private func setupHierarchy() {
        view.addSubview(userAvatar)
        view.addSubview(userNameField)
        view.addSubview(saveChangeButton)
    }

    // MARK: - Setup Layout
    private func setupLayout() {
        userAvatar.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
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

    // MARK: - Button's action
    @objc func saveChanges() {
        guard let name = userNameField.text else { return }
        presenter?.saveUserInfo(name: name)
    }

    @objc func chooseAvatar() {
        self.presenter?.chooseAvatar()
    }
}

extension UserOptionController: UserOptionViewProtocol {
    func getUserName(_ name: String) {
        self.userName = name
    }

    func getUserAvatar(_ url: URL?) {
        self.userAvatarUrl = url
    }
}

extension UserOptionController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
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

extension UserOptionController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return userNameField.resignFirstResponder()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

private enum UserOptionsSizes: CGFloat {
    case avatar = 300

    var value: CGFloat {
        switch self {
        case .avatar:
            UIScreen.main.bounds.height > 700 ? rawValue : 200
        }
    }
}
