//
//  BasePlaneButton.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 19.07.2024.
//

import UIKit

class BasePlaneButton: UIButton {
    
    init( text: String, color: UIColor) {
        super.init(frame: .zero).
        super.init(type: .system)
        self.setTitle(text, for: .normal)
        self.backgroundColor = color
        self.setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        self.tintColor = .systemCyan
    }
}
