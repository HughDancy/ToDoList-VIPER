//
//  MainToDoCell.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 14.03.2024.
//

import UIKit

class MainToDoCell: UICollectionViewCell {
    static let reuseIdentifier = "MainToDoCell"
    
    //MARK: - Outlets
    private lazy var containerView: UIView = {
        let container = UIView()
        container.backgroundColor = .systemGray5
        container.layer.cornerRadius = 15
        container.layer.shadowOffset = CGSize(width: 0, height: 2)
        container.layer.shadowRadius = 5
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowOpacity = 0.3
        return container
    }()
    
    private lazy var arrowIcon: UIImageView = {
        let arrow = UIImageView()
        arrow.image = UIImage(systemName: "arrow.right.circle.fill")
        arrow.tintColor = .systemGreen
        arrow.backgroundColor = .systemBackground
        return arrow
    }()
    
    private lazy var numbersLabel: UILabel = {
        let numbers = UILabel()
        numbers.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.height > 700 ? 60 : 30, weight: .bold)
        numbers.textColor = .systemBackground
        return numbers
    }()
    
    private lazy var toDosLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.height > 700 ? 20 : 17, weight: .semibold)
        label.textColor = .systemBackground
        return label
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.backgroundColor = .clear
        setupHierarchy()
        setupLayout()
    }
    
    //MARK: - Setup Hierarchy
    private func setupHierarchy() {
        contentView.addSubview(containerView)
        containerView.addSubview(numbersLabel)
        containerView.addSubview(toDosLabel)
    }
    
    //MARK: - Setup Layout
    private func setupLayout() {
        containerView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview().inset(5)
        }
        
        numbersLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        toDosLabel.snp.makeConstraints { make in
//            make.top.equalTo(numbersLabel.snp.bottom).offset(3)
            make.top.equalTo(numbersLabel.snp.bottom)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(10)
        }
    }
    
    //MARK: - Output setup outlets method
    func setupElements(numbers: Int, dayLabel: String, backgroundColor: UIColor) {
        numbersLabel.text = String(numbers)
        toDosLabel.text = dayLabel
        containerView.backgroundColor = backgroundColor
    }
}
