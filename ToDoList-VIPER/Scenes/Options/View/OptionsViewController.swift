//
//  OptionsViewController.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 03.07.2024.
//

import UIKit
import Kingfisher
import MessageUI

class OptionsViewController: UIViewController {
    //MARK: - Properties
    var presenter: OptionsPresenterProtocol?
    private var optionsData = [String]()
    private var userData: (String, URL?) = ("", nil)
    
    //MARK: - Outlets
    private lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "mainBackgroundImage")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var avatarImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = OptionsScreenSizes.avatarCornerRadius.value
        imageView.clipsToBounds = true
        imageView.kf.setImage(with: userData.1,
                              placeholder: UIImage(named: "mockUser_3"),
                              options: [
                                .cacheOriginalImage
                              ])
        return imageView
    }()
    
    private lazy var userName: UILabel = {
        let label = UILabel()
        label.text = UserDefaults.standard.string(forKey: NotificationNames.userName.rawValue)
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textColor = .systemBackground
        return label
    }()
    
    private lazy var changeUserData: UIButton = {
        let button = UIButton(type: .system)
        let titleFont = UIFont.systemFont(ofSize: OptionsScreenSizes.redacrButtonFont.value, weight: .medium)
        let attributes: [NSAttributedString.Key: Any] = [
                   .font: titleFont
               ]
        let atributeTitle = NSAttributedString(string: "Редактировать", attributes: attributes)
        button.setAttributedTitle(atributeTitle, for: .normal)
//        button.setTitle("Редактировать", for: .normal)
        button.tintColor = .systemOrange
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(goToUserOptions), for: .touchDown)
        return button
    }()
    
    private lazy var containerView: UIView = {
       let view = UIView()
        view.backgroundColor = .systemBackground
//        view.overrideUserInterfaceStyle = Theme.light.getUserInterfaceStyle()
        view.layer.cornerRadius = 40
        return view
    }()
    
    private lazy var optionsTable: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(OptionsCell.self, forCellReuseIdentifier: OptionsCell.reuseIdentifier)
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    //MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.overrideUserInterfaceStyle = ToDoUserDefaults.shares.theme.getUserInterfaceStyle()
        containerView.overrideUserInterfaceStyle = ToDoUserDefaults.shares.theme.getUserInterfaceStyle()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNotificationObserver()
        presenter?.getData()
        view.overrideUserInterfaceStyle = ToDoUserDefaults.shares.theme.getUserInterfaceStyle()
        setupHierarchy()
        setupLayout()
       
    }
    
    //MARK: - Setup outlets
    
    private func setupHierarchy() {
        view.addSubview(backgroundImage)
        view.sendSubviewToBack(backgroundImage)
        view.addSubview(avatarImage)
        view.addSubview(userName)
        view.addSubview(changeUserData)
        view.addSubview(containerView)
        containerView.addSubview(optionsTable)
    }
    
    private func setupLayout() {
        backgroundImage.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
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
        
        containerView.snp.makeConstraints { make in
            make.top.equalTo(changeUserData.snp.bottom).offset(15)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        optionsTable.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(35)
            make.leading.trailing.bottom.equalTo(containerView)
        }
    }
    
    //MARK: - Button's action
    @objc func goToUserOptions() {
        presenter?.goToUserOptions()
    }
    
    //MARK: - Notification Observer
    private func setupNotificationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateUserInfo), name: NotificationNames.updateUserData.name, object: nil)
    }
    
    @objc func updateUserInfo() {
        self.presenter?.updateUserData()
        self.userName.text = userData.0
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.5, execute: {
            self.avatarImage.kf.setImage(with: UserDefaults.standard.url(forKey: "UserAvatar"),
                                  placeholder: UIImage(named: "mockUser_3"),
                                  options: [
                                    .cacheOriginalImage
                                  ])
        })
        
    }
}

//MARK: - OptionsView Protocol Extension
extension OptionsViewController: OptionsViewProtocol {
    func getOptionsData(_ data: [String]) {
        self.optionsData = data
    }
    
    func getUserData(_ userData: (String, URL?)) {
        self.userData = userData
    }
}

//MARK: - TableView DataSource Extension
extension OptionsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OptionsCell.reuseIdentifier, for: indexPath) as? OptionsCell else { return UITableViewCell() }
        cell.setupCell(title: optionsData[indexPath.row], index: indexPath.row)
        cell.delegate = self
        return cell
    }
}

//MARK: - TableView Delegate Extension
extension OptionsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1:
            presenter?.getFeedback()
        case 2:
            presenter?.logOut()
        default:
            break
        }
    }
}

extension OptionsViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}

//MARK: - OptionCell delegate method
extension OptionsViewController: OptionCellDelegate {
    func changeTheme(_ bool: Bool) {
        self.presenter?.changeTheme(bool)
        view.overrideUserInterfaceStyle = ToDoUserDefaults.shares.theme.getUserInterfaceStyle()
        containerView.overrideUserInterfaceStyle = ToDoUserDefaults.shares.theme.getUserInterfaceStyle()
    }
}

//MARK: - OptionsScreen Sizes
fileprivate enum OptionsScreenSizes: CGFloat {
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
