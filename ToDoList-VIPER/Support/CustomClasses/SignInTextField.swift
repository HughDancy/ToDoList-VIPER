//
//  SignInTextField.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 01.03.2024.
//

import UIKit

class SignInTextField: UITextField {
    var nameOfImage: String
    
    init(placeholder: String, nameOfImage: String, tag: Int, delegate: UITextFieldDelegate, frame: CGRect, capitalizationType: UITextAutocapitalizationType, returnKey: UIReturnKeyType, secure: Bool) {
        self.nameOfImage = nameOfImage
        super.init(frame: frame)
        self.placeholder = placeholder
        self.tag = tag
        self.delegate = delegate
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
        let image = UIImageView(image: UIImage(systemName: nameOfImage))
        image.contentMode = .scaleAspectFit
        let stackContianer = UIStackView()
        stackContianer.axis = .horizontal
        stackContianer.spacing = 0
        stackContianer.distribution = .fillEqually
        stackContianer.addArrangedSubview(image)
        stackContianer.addArrangedSubview(UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 0)))
        self.leftView = stackContianer
        self.leftViewMode = .unlessEditing
        self.tintColor = .systemGray4
    }
}
