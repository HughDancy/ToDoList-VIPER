//
//  OptionsViewController.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 03.07.2024.
//

import UIKit

class OptionsViewController: UIViewController {
    //MARK: - Outlets
    private lazy var avatarImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = OptionsScreenSizes.avatarCornerRadius.value
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "mockUser_1")
        return imageView
    }()
    
    private lazy var userName: UILabel = {
        let label = UILabel()
        label.text = UserDefaults.standard.string(forKey: NotificationNames.userName.rawValue)
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        return label
    }()
    
    private lazy var changeUserData: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Редактировать", for: .normal)
        button.backgroundColor = .systemBackground
        return button
    }()
    
    private lazy var optionsTable: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(OptionsCell.self, forCellReuseIdentifier: OptionsCell.reuseIdentifier)
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupHierarchy()
        setupLayout()
        
    }
    
    //MARK: - Setup outlets
    
    private func setupHierarchy() {
        view.addSubview(avatarImage)
        view.addSubview(userName)
        view.addSubview(changeUserData)
        view.addSubview(optionsTable)
    }
    
    private func setupLayout() {
        avatarImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(15)
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
        
        optionsTable.snp.makeConstraints { make in
            make.top.equalTo(changeUserData.snp.bottom).offset(15)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

fileprivate enum OptionsScreenSizes: CGFloat {
    case avatarSize = 200
    case avatarCornerRadius = 100
    
    
    var value: CGFloat {
        switch self {
        case .avatarSize:
            UIScreen.main.bounds.height > 700 ? rawValue : 140
        case .avatarCornerRadius:
            UIScreen.main.bounds.height > 700 ? rawValue : 70
        }
    }
}

extension OptionsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OptionsCell.reuseIdentifier, for: indexPath) as? OptionsCell else { return UITableViewCell() }
        let data = ["Сменить тему", "Обратная связь", "Выход"]
        cell.setupCell(title: data[indexPath.row])
        return cell
    }
}

extension OptionsViewController: UITableViewDelegate {
    
}
