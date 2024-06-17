//
//  MainScreenView.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 21.03.2024.
//

import UIKit
import Kingfisher

final class MainScreenView: UIView {
    
    //MARK: - Outlets
    private lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "mainBackgroundImage")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var userAvatar: UIImageView = {
        let userAvatar = UIImageView()
        userAvatar.image = UIImage(named: "mockUserAvatar")
        userAvatar.contentMode = .scaleAspectFill
        userAvatar.layer.cornerRadius = MainScreenSizes.avatar.size / 2
        userAvatar.clipsToBounds = true
        return userAvatar
    }()
    
    private lazy var userName = UILabel.createSimpleLabel(text: "", size: 25, width: .semibold, color: .white)
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.shadowOffset = CGSize(width: 0, height: 10)
        view.layer.shadowRadius = 70
        view.layer.shadowColor = UIColor.white.cgColor
        view.layer.shadowOpacity = 3.0
        view.layer.cornerRadius = 50
        return view
    }()
    
    lazy var toDosCollection = MainScreenCollectionView()
    
    //MARK: - Init
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupHierarchy()
        setupLayout()
        self.backgroundColor = .systemBackground
    }
    
    //MARK: - Setup Hierarchy
    private func setupHierarchy() {
        self.addSubview(backgroundImage)
        self.sendSubviewToBack(backgroundImage)
        self.addSubview(userAvatar)
        self.addSubview(userName)
        self.addSubview(containerView)
        containerView.addSubview(toDosCollection)
    }
    
    //MARK: - Setup Layout
    private func setupLayout() {
        backgroundImage.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(-65)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(MainScreenSizes.backgroundImage.size)
        }
        
        userAvatar.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(7)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(MainScreenSizes.avatar.size)
        }
        
        userName.snp.makeConstraints { make in
            make.top.equalTo(userAvatar.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(130)
        }
        
        toDosCollection.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(70)
        }
    }
    
    //MARK: - Setup elements
    func setupElements(userName: String, userAvatar: URL?) {
        self.userAvatar.kf.setImage(
            with: userAvatar,
            placeholder: UIImage(named: "mockUser_3"),
            options: [
                .cacheOriginalImage
            ])
        self.userName.text = "Привет, \(userName)!"
    }
}

enum MainScreenSizes: CGFloat {
    case avatar = 80
    case backgroundImage = 350
    
    var size: CGFloat {
        switch self {
        case .avatar:
            let size: CGFloat = UIScreen.main.bounds.height > 700 ? 80 : 70
            return size
        case .backgroundImage:
            return rawValue
        }
    }
}
