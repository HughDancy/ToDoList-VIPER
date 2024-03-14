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
        container.backgroundColor = .systemGray4
        container.layer.cornerRadius = 15
        container.clipsToBounds = true
        return container
    }()
    
    private lazy var arrowIcon: UIImageView = {
        let arrow = UIImageView()
        arrow.image = UIImage(systemName: "arrow.right.circle.fill")
        arrow.tintColor = .systemGreen
        return arrow
    }()
    
    private lazy var numbersLabel: UILabel = {
        let numbers = UILabel()
        
        return numbers
    }()
    
    private lazy var toDosLabel: UILabel = {
        let label = UILabel()
        
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
        containerView.addSubview(containerView)
        containerView.addSubview(arrowIcon)
        containerView.addSubview(numbersLabel)
        containerView.addSubview(toDosLabel)
    }
    
    //MARK: - Setup Layout
    private func setupLayout() {
        containerView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview().inset(10)
        }
        
        arrowIcon.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(15)
        }
        
        numbersLabel.snp.makeConstraints { make in
            make.top.equalTo(arrowIcon.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }
        
        toDosLabel.snp.makeConstraints { make in
            make.top.equalTo(numbersLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
    }
    
    //MARK: - Output setup outlets method
    func setupElements(numbers: Int, dayLabel: String) {
        numbersLabel.text = String(numbers)
        toDosLabel.text = dayLabel
    }
}
