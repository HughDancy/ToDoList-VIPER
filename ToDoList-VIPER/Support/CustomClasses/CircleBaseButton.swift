//
//  CircleBaseButton.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 05.03.2024.
//

import UIKit
import SnapKit

final class CircleBaseButton: UIButton {
    var imageName: String?
    
    init(imageName: String?, color: UIColor, cornerRadius: CGFloat) {
        super.init(frame: .zero)
        self.imageName = imageName
        self.backgroundColor = color
        self.layer.cornerRadius = cornerRadius
        self.setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        self.tintColor = .systemBackground
        self.clipsToBounds = true
        self.setupLefImageView()
        self.snp.makeConstraints { make in
            make.height.width.equalTo(60)
        }
    }
    
    private func setupLefImageView() {
        switch imageName {
        case "googleLogo":
            let imageView = UIImageView(image: UIImage(named: imageName ?? "exclamationmark.triangle"))
            self.addSubview(imageView)
            imageView.snp.makeConstraints { make in
                make.centerY.centerX.equalTo(self.safeAreaLayoutGuide)
                make.height.width.equalTo(20)
            }
        default:
            let imageView = UIImageView(image: UIImage(systemName: imageName ?? "exclamationmark.triangle"))
            self.addSubview(imageView)
            imageView.snp.makeConstraints { make in
                make.centerY.centerX.equalTo(self.safeAreaLayoutGuide)
            }
        }
    }
    

}
