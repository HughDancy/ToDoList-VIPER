//
//  CalendarCollectionCell.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 26.03.2024.
//

import UIKit
import SnapKit

final class CalendarCollectionCell: UICollectionViewCell {
    static let reuseIdentifier = "CalndarCollectionCell"
    
    //MARK: - Outlets
    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var dayOfWeekLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0, weight: .semibold)
        label.textColor = .label
        return label
    }()
    
    private lazy var dayNumberLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0, weight: .semibold)
        label.textColor = self.isSelected ? .white  : .black
        return label
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        contentView.backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        setupHierarchy()
        setupLayout()
    }
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                containerView.backgroundColor = .systemIndigo
                dayNumberLabel.textColor = .white
            } else {
                containerView.backgroundColor = .systemGray6
                dayNumberLabel.textColor = .label
            }
        }
    }

    //MARK: - Setup Hierarchy
    private func setupHierarchy() {
        contentView.addSubview(containerView)
        containerView.addSubview(dayOfWeekLabel)
        containerView.addSubview(dayNumberLabel)
    }
    
    //MARK: - SetupLayout
    private func setupLayout() {
        containerView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview().inset(5)
        }
        
        dayOfWeekLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(10)
            make.centerX.equalTo(containerView.snp.centerX)
        }
        
        dayNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(dayOfWeekLabel.snp.bottom).offset(5)
            make.centerX.equalTo(containerView.snp.centerX)
        }
    }
    
    func setupCell(dayOfWeek: String, numberOfDay: String) {
        dayOfWeekLabel.text = dayOfWeek
        dayNumberLabel.text = numberOfDay
    }
    
    override func prepareForReuse() {
        dayOfWeekLabel.text = nil
        dayNumberLabel.text = nil
    }
}
