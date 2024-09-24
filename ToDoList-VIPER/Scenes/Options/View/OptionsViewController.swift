//
//  OptionsViewController.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 03.07.2024.
//

import UIKit
import Kingfisher
import MessageUI

final class OptionsViewController: UIViewController {
    // MARK: - Properties
    var presenter: OptionsPresenterProtocol?
    private var optionsData = [String]()
    private var userName: String = ""
    private var userAvatarUrl: URL?
    private var mainView: OptionView? {
        guard isViewLoaded else { return nil }
        return view as? OptionView
    }

    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.overrideUserInterfaceStyle = ToDoThemeDefaults.shared.theme.getUserInterfaceStyle()
        mainView?.containerView.overrideUserInterfaceStyle = ToDoThemeDefaults.shared.theme.getUserInterfaceStyle()
        setupNotificationObserver()
        self.tabBarController?.tabBar.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.getData()
        self.view = OptionView()
        view.overrideUserInterfaceStyle = ToDoThemeDefaults.shared.theme.getUserInterfaceStyle()
        setupMainView()
    }

    private func setupMainView() {
        mainView?.optionsTable.delegate = self
        mainView?.optionsTable.dataSource = self
        mainView?.changeUserData.addTarget(self, action: #selector(goToUserOptions), for: .touchDown)
    }

    // MARK: - Button's action
    @objc func goToUserOptions() {
        presenter?.goToUserOptions()
    }

    // MARK: - Notification Observer
    private func setupNotificationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateUserInfo), name: NotificationNames.updateUserData.name, object: nil)
    }

    @objc func updateUserInfo() {
        self.presenter?.updateUserData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.5, execute: {
            self.mainView?.setupUserAvatar(UserDefaults.standard.url(forKey: UserDefaults.Keys.userAvatar))
        })
        self.mainView?.setupUserName(self.userName)
    }
}

// MARK: - OptionsView Protocol Extension
extension OptionsViewController: OptionsViewProtocol {
    func getUserName(_ name: String) {
        self.userName = name
        self.mainView?.setupUserName(self.userName)
    }

    func getUserAvatar(_ url: URL?) {
        self.userAvatarUrl = url
        self.mainView?.setupUserAvatar(url)
    }

    func getOptionsData(_ data: [String]) {
        self.optionsData = data
    }
}

// MARK: - TableView DataSource Extension
extension OptionsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OptionsCell.reuseIdentifier, for: indexPath) as? OptionsCell
        else { return UITableViewCell() }
        cell.setupCell(title: optionsData[indexPath.row], index: indexPath.row)
        cell.delegate = self
        return cell
    }
}

// MARK: - TableView Delegate Extension
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

// MARK: - OptionCell delegate method
extension OptionsViewController: OptionCellDelegate {
    func changeTheme(_ bool: Bool) {
        self.presenter?.changeTheme(bool)
        view.overrideUserInterfaceStyle = ToDoThemeDefaults.shared.theme.getUserInterfaceStyle()
        mainView?.containerView.overrideUserInterfaceStyle = ToDoThemeDefaults.shared.theme.getUserInterfaceStyle()
    }
}
