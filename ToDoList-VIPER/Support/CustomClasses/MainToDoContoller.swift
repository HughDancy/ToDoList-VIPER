//
//  MainToDoContoller.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 15.03.2024.
//

import UIKit

class MainToDoContoller: UIViewController {
    
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
//        view.backgroundColor = UIColor(named: "mainScreenColor")
        view.backgroundColor = .systemBackground
        view.layer.shadowOffset = CGSize(width: 0, height: 10)
        view.layer.shadowRadius = 50
        view.layer.shadowColor = UIColor.white.cgColor
        view.layer.shadowOpacity = 3.0
        view.layer.cornerRadius = 50
        return view
    }()
    
     lazy var toDosCollection: UICollectionView = {
        let layout = createLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .systemBackground
//        collectionView.backgroundColor = UIColor(named: "mainScreenColor")
        collectionView.isScrollEnabled = true
//        collectionView.register(MainToDoCell.self, forCellWithReuseIdentifier: MainToDoCell.reuseIdentifier)
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupHierarcy()
        setupLayout()
    }
    
    //MARK: - Setup Hierarchy
    func setupHierarcy() {
        view.addSubview(backgroundImage)
        view.sendSubviewToBack(backgroundImage)
        view.addSubview(userAvatar)
        view.addSubview(userName)
        view.addSubview(containerView)
        containerView.addSubview(toDosCollection)
    }
    
    //MARK: - Setup Layout
    func setupLayout() {
        backgroundImage.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(-65)
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
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(150)
        }
        
        toDosCollection.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(70)
        }
    }
    
    //MARK: - CollectionView Layout
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
               }
               return layout
           }

  //MARK: - Setup Elements
    func setupElements(nameOfImage: String, userName: String) {
        self.userAvatar.image = UIImage(named: nameOfImage)
        self.userName.text = "Привет, \(userName)!"
    }
}
