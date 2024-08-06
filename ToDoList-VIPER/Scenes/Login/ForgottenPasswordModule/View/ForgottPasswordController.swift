//
//  ForgottPasswordController.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 07.06.2024.
//

import UIKit

final class ForgottPasswordController: UIViewController, ForgetPasswordViewProtocol {

    var presenter: ForgettPasswordPresenterProtocol?

    // MARK: - Outlets
    private lazy var resetPasswordImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "resetPassword")
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        return imageView
    }()

    private lazy var forgottLabel: UILabel = {
        let label = UILabel.createSimpleLabel(text: "Введите адрес Вашей электронной почты для сброса пароля",
                                              size: 25,
                                              width: .bold,
                                              color: .label,
                                              aligment: .center,
                                              numberLines: 0)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private lazy var emailTextField: UITextField = {
        let textField = UITextField.createToDoTextField(text: "",
                                                        textSize: 20,
                                                        weight: .semibold,
                                                        color: .systemGray5,
                                                        returnKey: .done)
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.accessibilityLabel = "ForggotenField"
        return textField
    }()

    private lazy var acceptButton: BaseButton = {
        let button = BaseButton(text: "Сбросить пароль", color: .systemCyan)
        button.setupShadows(with: .label)
        button.addTarget(self, action: #selector(getResetPassword), for: .touchDown)
        return button
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        view.backgroundColor = .systemBackground
        setupHierarchy()
        setupLayout()
    }

    deinit {
        print("ForgettPasswordController is ☠️")
    }

    // MARK: - Setup Outlets
    private func setupHierarchy() {
        view.addSubview(resetPasswordImage)
        view.addSubview(forgottLabel)
        view.addSubview(emailTextField)
        view.addSubview(acceptButton)
    }

    private func setupLayout() {
        resetPasswordImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(ResetPassSizes.imageTopOffset.value)
            make.height.width.equalTo(250)
            make.leading.trailing.equalToSuperview().inset(ResetPassSizes.imageAndFieldHorizontalOffset.value)
        }

        forgottLabel.snp.makeConstraints { make in
            make.top.equalTo(resetPasswordImage.snp.bottom).offset(ResetPassSizes.labelAndFontTopOffset.value)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(ResetPassSizes.labelHorizontalOffset.value)
        }

        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(forgottLabel.snp.bottom).offset(ResetPassSizes.labelAndFontTopOffset.value)
            make.leading.trailing.equalToSuperview().inset(ResetPassSizes.imageAndFieldHorizontalOffset.value)
            make.height.equalTo(ResetPassSizes.buttonAndFieldHeight.value)
        }

        acceptButton.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalTo(ResetPassSizes.buttonAndFieldHeight.value)
        }
    }

    // MARK: - Button Action
    @objc func getResetPassword() {
        presenter?.resetPassword(with: emailTextField.text ?? "")
    }
}
    // MARK: - TextField Extension
extension ForgottPasswordController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return emailTextField.resignFirstResponder()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

private enum ResetPassSizes: CGFloat {
    case imageTopOffset = 100
    case imageAndFieldHorizontalOffset = 30
    case buttonAndFieldHeight = 40
    case labelAndFontTopOffset = 15
    case labelHorizontalOffset = 20

    var value: CGFloat {
        switch self {
        case .imageTopOffset:
             (UIScreen.main.bounds.height / 5.0) - (UIScreen.main.bounds.width / 5.0)
        case .imageAndFieldHorizontalOffset:
             30
        case .buttonAndFieldHeight:
            40
        case .labelAndFontTopOffset:
            15
        case .labelHorizontalOffset:
            20
        }
    }
}
