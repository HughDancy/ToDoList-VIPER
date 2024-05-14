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
    func updateTasks(with data: Date)
}

class CalendarCollectionView: UICollectionView {
    //MARK: - Properties
    private let layoutCollection = UICollectionViewFlowLayout()
    var selectedUserCell = 10
    
     var centerDate = Date()
    
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
        self.reloadData()
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
   
extension CalendarCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        totalSquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCollectionCell.reuseIdentifier, for: indexPath) as? CalendarCollectionCell else { return UICollectionViewCell() }
        cell.setupCell(totalSquares[indexPath.row])
        if cell.dateString == DateFormatter.getStringFromDate(from: centerDate)  {
            selectItem(at: [0, indexPath.row], animated: false, scrollPosition: [])
            cell.isSelected = true
        }
        return cell
    }
    
    override func numberOfItems(inSection section: Int) -> Int {
        totalSquares.count
    }
    
}

extension CalendarCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedUserCell = indexPath.row
        centerDate = totalSquares[indexPath.row].date
        calendarDelegate?.updateTasks(with: totalSquares[indexPath.row].date)
    }
}

extension CalendarCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = frame.width / 7.7
        let height = frame.height - 25.0 //early was - 23.0
        return CGSize(width: width, height: height)
    }
}
