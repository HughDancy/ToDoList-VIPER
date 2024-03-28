//
//  CalendarCollection.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 28.03.2024.
//

import UIKit

protocol CalendarCollectionViewDelegate: AnyObject {
    func scrollLeft()
    func scrollRight()
}

class CalendarCollectionView: UICollectionView {
    
    let selectedDate: String = DateFormatter.createMediumDate(from: Date.today)
    private let layoutCollection = UICollectionViewFlowLayout()
    let selectedUserCell = 10
    
    private var centerDate = Date()
    weak var calendarDelegate: CalendarCollectionViewDelegate?
    var totalSquares = [DateItem]()
    
    //MARK: - Init
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    //MARK: - Settings
    private func commonInit() {
        setupView()
    }
    
    private func setupView() {
        register(CalendarCollectionCell.self,
                 forCellWithReuseIdentifier: CalendarCollectionCell.reuseIdentifier)
        bounces = false
        backgroundColor = .none
        showsHorizontalScrollIndicator = false
        setCollectionViewLayout(layoutCollection, animated: false)
        setupCollectionViewLayout(layout: layoutCollection)
    }
    
    private func setupCollectionViewLayout(layout: UICollectionViewFlowLayout) {
        layout.minimumLineSpacing = 6
        layout.scrollDirection = .horizontal
    }
    
    func setDaysArray(days: [DateItem]) {
        self.totalSquares = days
    }
    
    //MARK: - ScrollViewDidScroll method
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x < 6 {
            calendarDelegate?.scrollLeft()
        }
        
        if scrollView.contentOffset.x > frame.width * 2 {
            calendarDelegate?.scrollRight()
        }
    }
}
   
