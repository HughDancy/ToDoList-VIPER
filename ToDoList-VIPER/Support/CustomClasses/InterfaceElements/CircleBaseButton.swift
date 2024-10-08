//
//  CircleBaseButton.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 05.03.2024.
//

import UIKit

final class CircleBaseButton: UIButton {
    var imageName: String?
    var typeOfImage: ImageTypeForButton?

    init(imageName: String?, typeOfImage: ImageTypeForButton, color: UIColor, cornerRadius: CGFloat) {
        super.init(frame: .zero)
        self.imageName = imageName
        self.typeOfImage = typeOfImage
        self.backgroundColor = color
        self.layer.cornerRadius = cornerRadius
        self.accessibilityLabel = imageName ?? "circleButton"
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
        switch typeOfImage {
        case .customImage:
            let imageView = UIImageView(image: UIImage(named: imageName ?? "exclamationmark.triangle"))
            self.addSubview(imageView)
            imageView.snp.makeConstraints { make in
                make.centerY.centerX.equalTo(self.safeAreaLayoutGuide)
                make.height.width.equalTo(20)
            }
        case .systemImage:
            let imageView = UIImageView(image: UIImage(systemName: imageName ?? "exclamationmark.triangle"))
            self.addSubview(imageView)
            imageView.snp.makeConstraints { make in
                make.centerY.centerX.equalTo(self.safeAreaLayoutGuide)
            }
        default:
            break
        }
      }
}

enum ImageTypeForButton {
    case systemImage
    case customImage
}
