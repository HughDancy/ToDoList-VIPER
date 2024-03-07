//
//  BaseButton.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 01.03.2024.
//

import UIKit

class BaseButton: UIButton {
 
    init( text: String, color: UIColor) {
        super.init(frame: .zero)
        self.setTitle(text, for: .normal)
        self.backgroundColor = color
        self.setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        self.tintColor = .systemBackground
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
}
