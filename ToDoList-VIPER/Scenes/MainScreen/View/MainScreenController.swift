//
//  MainScreenController.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 14.03.2024.
//

import UIKit

final class MainScreenController: UIViewController {
    var presenter: MainScreenPresenterProtocol?

    // MARK: - Outelts
    let mockColors: [UIColor] = [.systemOrange, .systemRed, .systemTeal, .systemGreen]
    var userName: String = ""
    var userAvatar: URL?
    var toDosInfo: [[String]] = [[]] {
        didSet {
            self.mainView?.toDosCollection.reloadData()
        }
    }

    private var mainView: MainScreenView? {
        guard isViewLoaded else { return nil }
        return view as? MainScreenView
    }

    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
        subcribeToNotification()
        self.updateDownloadTask()
        self.tabBarController?.tabBar.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.getToDosCount()
        presenter?.updateUserData()
        view = MainScreenView()
        self.setupMainViewElements()
        setupCollectionView()
    }

    // MARK: - Setup Outlets
    func setupCollectionView() {
        mainView?.toDosCollection.dataSource = self
        mainView?.toDosCollection.delegate = self
    }

    private func setupNavigationBar() {
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }

    func setupMainViewElements() {
        self.mainView?.setupName(userName: userName)
        self.mainView?.setupAvatar(url: userAvatar)
    }

    // MARK: - Notification
    func subcribeToNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(mustUpdateData), name: NotificationNames.updateMainScreen.name, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateUserData), name: NotificationNames.updateUserData.name, object: nil)
    }

    @objc func mustUpdateData() {
        self.presenter?.getToDosCount()
    }

    @objc func updateUserData() {
        self.presenter?.updateUserData()
        self.mainView?.setupName(userName: userName)
    }

    private func updateDownloadTask() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            self.presenter?.getToDosCount()
        })
    }
}
// MARK: - CollectionView Delegate
extension MainScreenController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return toDosInfo.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainToDoCell.reuseIdentifier, for: indexPath) as? MainToDoCell else {
            return UICollectionViewCell()
        }
        cell.setupElements(numbers: Int(toDosInfo[indexPath.row][0]) ?? 0, dayLabel: toDosInfo[indexPath.row][1], backgroundColor: mockColors[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.presenter?.goToTodos(with: .today)
        case 1:
            self.presenter?.goToTodos(with: .overdue)
        case 2:
            self.presenter?.goToTodos(with: .tommorow)
        case 3:
            self.presenter?.goToTodos(with: .done)
        default:
            print("No cell action")
        }
    }
}

// MARK: - MainScreenViewPtorocol Extension
extension MainScreenController: MainScreenViewProtocol {
    func getUserName(_ userName: String) {
        self.userName = userName
    }

    func getUserAvatar(_ userAvatar: URL?) {
        self.userAvatar = userAvatar
        self.mainView?.setupAvatar(url: userAvatar)
    }

    func getToDosCount(_ toDosCount: [[String]]) {
        self.toDosInfo = toDosCount
    }
}
