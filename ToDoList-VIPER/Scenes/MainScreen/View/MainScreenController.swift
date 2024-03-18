//
//  MainScreenController.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 14.03.2024.
//

import UIKit
import SnapKit

final class MainScreenController: MainToDoContoller {
    var presenter: MainScreenPresenterProtocol?
    
    let mockData = [["1", "Запланированно сегодня"], ["3", "просроченно"], ["10", "Запланированно на завтра"], ["50", "выполненно"]]
    let mockColors: [UIColor] = [.systemOrange, .systemRed, .systemTeal, .systemGreen]
    
    var userData: [String] = []
    var toDosInfo: [[String]] = [[]] {
        didSet {
            self.toDosCollection.reloadData()
        }
    }
    
   //MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
        self.setupElements(nameOfImage: userData[1], userName: userData[0])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    //MARK: - Setup Collection View
    func setupCollectionView() {
        self.toDosCollection.dataSource = self
        self.toDosCollection.delegate = self
        self.toDosCollection.register(MainToDoCell.self, forCellWithReuseIdentifier: MainToDoCell.reuseIdentifier)
    }
 
}
    //MARK: - CollectionView Delegate
extension MainScreenController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mockData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainToDoCell.reuseIdentifier, for: indexPath) as? MainToDoCell
//        cell?.setupElements(numbers: Int(mockData[indexPath.row][0]) ?? 5, dayLabel: mockData[indexPath.row][1], backgroundColor: mockColors[indexPath.row])
        cell?.setupElements(numbers: Int(toDosInfo[indexPath.row][0]) ?? 0, dayLabel: toDosInfo[indexPath.row][1], backgroundColor: mockColors[indexPath.row])
        return cell ?? UICollectionViewCell()
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
