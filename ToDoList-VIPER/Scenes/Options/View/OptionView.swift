//
//  OptionView.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 23.07.2024.
//

import UIKit

final class OptionView: UIView {
    // MARK: - Outlets
    lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "mainBackgroundImage")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    lazy var avatarImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = OptionsScreenSizes.avatarCornerRadius.value
        imageView.clipsToBounds = true
        imageView.kf.setImage(with: UserDefaults.standard.url(forKey: UserDefaultsNames.userAvatar.name),
                              placeholder: UIImage(named: "mockUser_3"),
                              options: [
                                .cacheOriginalImage
                              ])
        return imageView
    }()

    lazy var userName: UILabel = {
        let label = UILabel()
        label.text = UserDefaults.standard.string(forKey: UserDefaultsNames.userName.name)
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textColor = .systemBackground
        return label
    }()

    lazy var changeUserData: UIButton = {
        let button = UIButton(type: .system)
        let titleFont = UIFont.systemFont(ofSize: OptionsScreenSizes.redacrButtonFont.value, weight: .medium)
        let attributes: [NSAttributedString.Key: Any] = [
                   .font: titleFont
               ]
        let atributeTitle = NSAttributedString(string: "Редактировать", attributes: attributes)
        button.setAttributedTitle(atributeTitle, for: .normal)
        button.tintColor = .systemOrange
        button.backgroundColor = .clear
        return button
    }()

    lazy var containerView: UIView = {
       let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 40
        return view
    }()

    lazy var optionsTable: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(OptionsCell.self, forCellReuseIdentifier: OptionsCell.reuseIdentifier)
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        tableView.accessibilityLabel = "OptionsTable"
        return tableView
    }()

    // MARK: - Init
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

    // MARK: - Setup Hierarchy
    private func setupHierarchy() {
        self.addSubview(backgroundImage)
        self.sendSubviewToBack(backgroundImage)
        self.addSubview(avatarImage)
        self.addSubview(userName)
        self.addSubview(changeUserData)
        self.addSubview(containerView)
        containerView.addSubview(optionsTable)
    }

    // MARK: - Setup Layout
    private func setupLayout() {
        backgroundImage.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }

        avatarImage.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(15)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(OptionsScreenSizes.avatarSize.value)
        }

        userName.snp.makeConstraints { make in
            make.top.equalTo(avatarImage.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }

        changeUserData.snp.makeConstraints { make in
            make.top.equalTo(userName.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
        }

        containerView.snp.makeConstraints { make in
            make.top.equalTo(changeUserData.snp.bottom).offset(15)
            make.leading.trailing.bottom.equalToSuperview()
        }

        optionsTable.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(35)
            make.leading.trailing.bottom.equalTo(containerView)
        }
    }

    func setupUserName(_ name: String) {
        self.userName.text = name
    }

    func setupUserAvatar(_ url: URL?) {
        self.avatarImage.kf.setImage(with: url,
                                     placeholder: UIImage(named: "mockUser_3"),
                                     options: [
                                       .cacheOriginalImage
                                     ])
    }
}

// MARK: - OptionsScreen Sizes
private enum OptionsScreenSizes: CGFloat {
    case avatarSize = 200
    case avatarCornerRadius = 100
    case userNameFont = 35
    case redacrButtonFont = 18

    var value: CGFloat {
        switch self {
        case .avatarSize:
            UIScreen.main.bounds.height > 700 ? rawValue : 140
        case .avatarCornerRadius:
            UIScreen.main.bounds.height > 700 ? rawValue : 70
        case .userNameFont:
            UIScreen.main.bounds.height > 700 ? rawValue : 25
        case .redacrButtonFont:
            UIScreen.main.bounds.height > 700 ? rawValue : 15
        }
    }
}
