//
//  SignInTextField.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 01.03.2024.
//

import UIKit

class SignInTextField: UITextField {
    var nameOfImage: String?
    
    init(placeholder: String, nameOfImage: String?, tag: Int, delegate: UITextFieldDelegate, capitalizationType: UITextAutocapitalizationType, returnKey: UIReturnKeyType, secure: Bool) {
        self.nameOfImage = nameOfImage
        super.init(frame: .zero)
        self.placeholder = placeholder
        self.tag = tag
        self.delegate = delegate
//        self.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        self.autocapitalizationType = capitalizationType
        self.returnKeyType = returnKey
        self.isSecureTextEntry = secure
        self.setupTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTextField() {
        self.borderStyle = .none
        if nameOfImage != nil {
            let image = UIImageView(image: UIImage(systemName: nameOfImage ?? "apple.logo"))
            image.contentMode = .scaleAspectFit
            let stackContainer = UIStackView()
            stackContainer.axis = .horizontal
            stackContainer.spacing = 0
            stackContainer.distribution = .fillEqually
            stackContainer.addArrangedSubview(image)
            stackContainer.addArrangedSubview(UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 0)))
            self.leftView = stackContainer
            self.leftViewMode = .always
        } else {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
            self.leftView = view
            self.leftViewMode = .always
        }
        self.tintColor = .systemGray4
    }
}
