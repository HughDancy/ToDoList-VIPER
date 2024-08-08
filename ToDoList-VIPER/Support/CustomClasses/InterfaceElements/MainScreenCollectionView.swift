//
//  MainScreenCollectionView.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 02.05.2024.
//

import UIKit

final class MainScreenCollectionView: UICollectionView {

    // MARK: - Init
    init() {
        super.init(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        self.setupCollectionView()
        self.collectionViewLayout = self.setupCollectionLayout()
        self.accessibilityLabel = "MainCollectionView"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup Layout
    private func setupCollectionView() {
        self.register(MainToDoCell.self, forCellWithReuseIdentifier: MainToDoCell.reuseIdentifier)
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        self.backgroundColor = .systemBackground
        self.isScrollEnabled = true
        self.isScrollEnabled = false
    }

    // MARK: - Setup CollectionView Layout
    private func setupCollectionLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (_: Int, _: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

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
}
