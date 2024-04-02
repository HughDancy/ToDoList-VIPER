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
    func updateTasks(with data: String)
}

class CalendarCollectionView: UICollectionView {
    
    var selectedDate: String = DateFormatter.getStringFromDate(from: Date.tomorrow)
    private let layoutCollection = UICollectionViewFlowLayout()
    var selectedUserCell = 10
    
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
        delegate = self
        dataSource = self
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
   
extension CalendarCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        totalSquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCollectionCell.reuseIdentifier, for: indexPath) as? CalendarCollectionCell else { return UICollectionViewCell() }
        cell.setupCell(totalSquares[indexPath.row])
        if indexPath.row == selectedUserCell {
            selectItem(at: [0, selectedUserCell], animated: false, scrollPosition: [])
        }
        return cell
    }
    
    override func numberOfItems(inSection section: Int) -> Int {
        totalSquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedUserCell = indexPath.row
        selectedDate = totalSquares[indexPath.item].dateString
        calendarDelegate?.updateTasks(with: totalSquares[indexPath.row].dateString)
    }
}

extension CalendarCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = frame.width / 7.7
        let height = frame.height - 23.0
        return CGSize(width: width, height: height)
    }
}
