//
//  HorizontalCalendarView.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 27.03.2024.
//

import UIKit

final class HorizontalCalendarView: UIView {
    //MARK: - OUTLETS
    lazy var calendar: CalendarCollectionView = {
        let collectionView = CalendarCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        return collectionView
    }()
    
    private lazy var monthLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    //MARK: - Setup Outlets
    private func commonInit() {
        setupHierarchy()
        setupLayout()
    }
    
    private func setupHierarchy() {
        self.addSubview(monthLabel)
        self.addSubview(calendar)
    }
    
    private func setupLayout() {
        monthLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.equalToSuperview().offset(15)
        }
        
        calendar.snp.makeConstraints { make in
            make.top.equalTo(monthLabel.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview().inset(8)
            make.height.equalTo(90)
        }
    }
    
    func setupMonthLabel(with label: String) {
        let date = Date.today
        let year = date.getYear(date: date)
        self.monthLabel.text = "\(label) \(year)"
    }
}

