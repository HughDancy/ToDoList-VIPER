//
//  MainScreenController.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 14.03.2024.
//

import UIKit
import SnapKit

final class MainScreenController: MainToDoContoller {
    let mockData = [["1", "Запланированно сегодня"], ["3", "просроченно"], ["10", "Запланированно на завтра"], ["50", "выполненно"]]
    let mockColors: [UIColor] = [.systemOrange, .systemRed, .systemTeal, .systemGreen]
    
   //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupElements(nameOfImage: "mockUserAvatar", userName: "Винеамин")
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
        cell?.setupElements(numbers: Int(mockData[indexPath.row][0]) ?? 5, dayLabel: mockData[indexPath.row][1], backgroundColor: mockColors[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
}
