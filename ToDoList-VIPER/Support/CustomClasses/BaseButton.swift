//
//  BaseButton.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 01.03.2024.
//

import UIKit

class BaseButton: UIButton {
    var imageName: String?
    
    init(imageName: String?, text: String, color: UIColor) {
        super.init(frame: .zero)
        self.imageName = imageName
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
        self.setupLefImageView()
    }
    
    private func setupLefImageView() {
        switch imageName {
        case "googleLogo":
            let imageView = UIImageView(image: UIImage(named: imageName ?? "exclamationmark.triangle"))
            self.addSubview(imageView)
            imageView.snp.makeConstraints { make in
                make.centerY.equalTo(self.safeAreaLayoutGuide.snp.centerY)
                make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(23)
                make.height.width.equalTo(20)
            }
        case "apple.logo":
            let imageView = UIImageView(image: UIImage(systemName: imageName ?? "exclamationmark.triangle"))
            self.addSubview(imageView)
            imageView.snp.makeConstraints { make in
                make.centerY.equalTo(self.safeAreaLayoutGuide.snp.centerY)
                make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(25)
            }
        default:
            break
        }
    }
}
