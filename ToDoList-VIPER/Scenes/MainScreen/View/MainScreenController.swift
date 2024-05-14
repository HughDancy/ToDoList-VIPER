//
//  MainScreenController.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 14.03.2024.
//

import UIKit
import SnapKit

final class MainScreenController: UIViewController {
    var presenter: MainScreenPresenterProtocol?
    
    //MARK: - Outelts
    let mockColors: [UIColor] = [.systemOrange, .systemRed, .systemTeal, .systemGreen]
    
    var userData: [String] = []
    var toDosInfo: [[String]] = [[]] {
        didSet {
            self.mainView?.toDosCollection.reloadData()
        }
    }
    
    private var mainView: MainScreenView? {
        guard isViewLoaded else { return nil }
        return view as? MainScreenView
    }
    
   //MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
        presenter?.getToDosCount()
        mainView?.setupElements(nameOfImage: userData[1], userName: userData[0])
        subcribeToNotification()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = MainScreenView()
        setupCollectionView()
    }
    
    //MARK: - Setup Outlets
    func setupCollectionView() {
        mainView?.toDosCollection.dataSource = self
        mainView?.toDosCollection.delegate = self
    }
    
    private func setupNavigationBar() {
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
 
    //MARK: - Notification
    func subcribeToNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(mustUpdateData), name: NotificationNames.updateMainScreen.name, object: nil)
    }
    
    @objc func mustUpdateData() {
        self.presenter?.getToDosCount()
    }
}
    //MARK: - CollectionView Delegate
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
            self.presenter?.goToTodayToDos()
        case 1:
            self.presenter?.goToOverdueToDos()
        case 2:
            self.presenter?.goToTommorowToDos()
        case 3:
            self.presenter?.goToDoneToDos()
        default:
            print("No cell action")
        }
    }
}

  //MARK: - MainScreenViewPtorocol Extension
extension MainScreenController: MainScreenViewProtocol {
    func getUserData(_ userInfo: [String]) {
        self.userData = userInfo
    }
    
    func getToDosCount(_ toDosCount: [[String]]) {
        self.toDosInfo = toDosCount
    }
}
