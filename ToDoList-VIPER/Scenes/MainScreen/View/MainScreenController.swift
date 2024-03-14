//
//  MainScreenController.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 14.03.2024.
//

import UIKit
import SnapKit

final class MainScreenController: UIViewController {
    let something = [ [ ["1", "Today"], ["3", "is fuck"] ], [["10", "tommorow"], ["50", "is done"] ]    ]
    let mockData = [["1", "Запланированно сегодня"], ["3", "просроченно"], ["10", "Запланированно на завтра"], ["50", "выполненно"]]
    let mockColors: [UIColor] = [.systemOrange, .systemRed, .systemTeal, .systemGreen]
    
    //MARK: - OUTLETS
    private lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "mainBackgroundImage")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private lazy var userAvatar: UIImageView = {
        let userAvatar = UIImageView()
        userAvatar.image = UIImage(named: "mockUserAvatar")
        userAvatar.contentMode = .scaleAspectFit
        userAvatar.layer.cornerRadius = 30
        userAvatar.clipsToBounds = true
        return userAvatar
    }()
    
    private lazy var userName: UILabel = {
       let userName = UILabel()
        userName.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        userName.textColor = .white
        userName.text = "Привет, Дональд!"
        userName.numberOfLines = 0
        return userName
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 50
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var toDosCollection: UICollectionView = {
        let layout = createLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .systemBackground
        collectionView.isScrollEnabled = true
        collectionView.register(MainToDoCell.self, forCellWithReuseIdentifier: MainToDoCell.reuseIdentifier)
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
        view.backgroundColor = .systemBackground
    }
    
    //MARK: - SetupHierarchy
    private func setupHierarchy() {
        view.addSubview(backgroundImage)
        view.sendSubviewToBack(backgroundImage)
        view.addSubview(userAvatar)
        view.addSubview(userName)
        view.addSubview(containerView)
        containerView.addSubview(toDosCollection)
    }
    
    //MARK: - Setup Layout
    private func setupLayout() {
        backgroundImage.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(-55)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(350)
        }
        
        userAvatar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(60)
        }
        
        userName.snp.makeConstraints { make in
            make.top.equalTo(userAvatar.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(130)
        }
        
        toDosCollection.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(70)
        }
    }
    
    //MARK: -
    
    func createLayout() -> UICollectionViewLayout {
               let layout = UICollectionViewCompositionalLayout {
                   (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
                   let topItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.6)))
                   topItem.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)
                   let bottomNestedItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)))
                   let nestedBottomGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(0.3)),
                    subitems: [bottomNestedItem])
                   let rigthNestedGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.5),
                    heightDimension: .fractionalHeight(1.0)),
                    subitems: [topItem, nestedBottomGroup])
                   
                   let leftTopItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(0.3)))
                   let bottonLeftNestedItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)))
                   let leftNestedBottomGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(0.6)),
                    subitems: [bottonLeftNestedItem])
                   let leftNestedGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.5),
                    heightDimension: .fractionalHeight(1.0)),
                    subitems: [leftTopItem, leftNestedBottomGroup])
                   
                   let parrentGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)),
                    subitems: [rigthNestedGroup, leftNestedGroup])
                   
                   let section = NSCollectionLayoutSection(group: parrentGroup)
                   section.orthogonalScrollingBehavior = .continuous
                   return section
                   
                   
//                   switch sectionIndex {
//                   case 0 :
//                       let topItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
//                        widthDimension: .fractionalWidth(1.0),
//                        heightDimension: .fractionalHeight(0.6)))
//                       topItem.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
//                       let bottomItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
//                        widthDimension: .fractionalWidth(1.0),
//                        heightDimension: .fractionalHeight(1.0)))
//                       let bottomNestedGroup = NSCollectionLayoutGroup.vertical(
//                        layoutSize: NSCollectionLayoutSize(
//                            widthDimension: .fractionalWidth(1.0),
//                            heightDimension: .fractionalHeight(0.3)),
//                        subitems: [bottomItem])
//                       let itemsGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(
//                        widthDimension: .fractionalWidth(0.5),
//                        heightDimension: .fractionalHeight(1.0)), subitems: [topItem, bottomNestedGroup])
//                       let section = NSCollectionLayoutSection(group: itemsGroup)
//                       section.orthogonalScrollingBehavior = .continuous
//                       return section
//                   case 1:
//                       let topItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
//                        widthDimension: .fractionalWidth(1.0),
//                        heightDimension: .fractionalHeight(0.3)))
//                       topItem.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
//                       let bottomItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
//                        widthDimension: .fractionalWidth(1.0),
//                        heightDimension: .fractionalHeight(1.0)))
//                       let bottomNestedGroup = NSCollectionLayoutGroup.vertical(
//                        layoutSize: NSCollectionLayoutSize(
//                            widthDimension: .fractionalWidth(1.0),
//                            heightDimension: .fractionalHeight(0.6)),
//                        subitems: [bottomItem])
//                       let itemsGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(
//                        widthDimension: .fractionalWidth(0.5),
//                        heightDimension: .fractionalHeight(1.0)), subitems: [topItem, bottomNestedGroup])
//                       let section = NSCollectionLayoutSection(group: itemsGroup)
//                       section.orthogonalScrollingBehavior = .continuous
//                       return section
//                   default:
//                       let topItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
//                        widthDimension: .fractionalWidth(1.0),
//                        heightDimension: .fractionalHeight(0.3)))
//                       topItem.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
//                       let bottomItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
//                        widthDimension: .fractionalWidth(1.0),
//                        heightDimension: .fractionalHeight(1.0)))
//                       let bottomNestedGroup = NSCollectionLayoutGroup.vertical(
//                        layoutSize: NSCollectionLayoutSize(
//                            widthDimension: .fractionalWidth(1.0),
//                            heightDimension: .fractionalHeight(0.6)),
//                        subitems: [bottomItem])
//                       let rightItemsGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(
//                        widthDimension: .fractionalWidth(0.5),
//                        heightDimension: .fractionalHeight(1.0)), subitems: [topItem, bottomNestedGroup])
//                       
//                       
//                       
//                       let section = NSCollectionLayoutSection(group: itemsGroup)
//            
//                       return section
//                   }
//                   
                   
//                   
//                   let leadingItem = NSCollectionLayoutItem(
//                       layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7),
//                                                          heightDimension: .fractionalHeight(1.0)))
//                   leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
//
//                   let trailingItem = NSCollectionLayoutItem(
//                       layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
//                                                          heightDimension: .fractionalHeight(0.3)))
//                   trailingItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
//                   let trailingGroup = NSCollectionLayoutGroup.vertical(
//                       layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3),
//                                                          heightDimension: .fractionalHeight(1.0)),
//                       subitem: trailingItem, count: 2)
//
//                   let bottomNestedGroup = NSCollectionLayoutGroup.horizontal(
//                       layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
//                                                          heightDimension: .fractionalHeight(0.6)),
//                       subitems: [leadingItem, trailingGroup])
//
//                   let topItem = NSCollectionLayoutItem(
//                       layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
//                                                      heightDimension: .fractionalHeight(0.3)))
//                   topItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
//
//                   let nestedGroup = NSCollectionLayoutGroup.horizontal(
//                    layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
//                                                          heightDimension: .fractionalHeight(0.5)),
//                       subitems: [topItem, bottomNestedGroup])
//                   
//                   let secondNestedGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(0.4)),
//                                                                              subitems: [topItem, bottomNestedGroup])
//                   let section = NSCollectionLayoutSection(group: secondNestedGroup)
//                   section.orthogonalScrollingBehavior = .continuous
//                   return section

               }
               return layout
           }
    
    
}

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
