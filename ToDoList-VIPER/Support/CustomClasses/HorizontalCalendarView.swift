//
//  HorizontalCalendarView.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 27.03.2024.
//

import UIKit
import SnapKit

final class HorizontalCalendarView: UIView {
    //MARK: - OUTLETS
    lazy var calendar: CalendarCollectionView = {
        let collectionView = CalendarCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        return collectionView
    }()
    
    private lazy var monthLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        label.textColor = .systemCyan
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
        self.monthLabel.text = label
    }
}

//final class HorizontalCalendarView: UIView {
//    var selectedDate = DateFormatter.createMediumDate(from: Date.today)
//    var monthToShow: String = ""
//    var lastDateInArray: String = ""
//    var firstDayInArray: String = ""
//    var sevenDates: [String] = []
//    var dayName = ""
//    var selectedIndex = 0
//    
//    //MARK: - Outlets
//    lazy var calendarView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.register(CalendarCollectionCell.self, forCellWithReuseIdentifier: CalendarCollectionCell.reuseIdentifier)
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
//        collectionView.showsHorizontalScrollIndicator = false
//        collectionView.showsVerticalScrollIndicator = false
//        collectionView.backgroundColor = .systemBackground
//        collectionView.isScrollEnabled = false
//        return collectionView
//    }()
//    
//    
//    //MARK: - Init
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.backgroundColor = .systemBackground
//        self.addSubview(calendarView)
//        setupLayout()
//        getSevenDays()
//        preformGesture()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    //MARK: - Setup Layout
//    private func setupLayout() {
//        calendarView.snp.makeConstraints { make in
//            make.top.leading.trailing.bottom.equalToSuperview()
//        }
//    }
//    
//    private func createCollectionViewLayout() -> UICollectionViewLayout {
//        let layout = UICollectionViewCompositionalLayout {
//            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
//            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
//            let item = NSCollectionLayoutItem(layoutSize: itemSize)
//            item.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)
//            
//            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.14), heightDimension: .fractionalHeight(1.0))
//            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//            let section = NSCollectionLayoutSection(group: group)
//            section.orthogonalScrollingBehavior = .groupPagingCentered
//            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0)
//            return section
//        }
//        return layout
//    }
//}
//
////MARK: - Calendar support methods
//extension HorizontalCalendarView {
//    func getSevenDays() {
//        let selectedDataInString = self.selectedDate
//        let dateFormatter = DateFormatter()
//        dateFormatter.locale = Locale(identifier: "ru_RU")
//        dateFormatter.dateFormat = "dd-MM-yyyy"
//        let date = dateFormatter.date(from: selectedDataInString)
//        
//        let dateFormatterWeekDay = DateFormatter()
//        dateFormatterWeekDay.dateFormat = "EEEE"
//        let weekDay = dateFormatterWeekDay.string(from: date ?? Date.today)
//        print(weekDay)
//        self.selectedIndex = 0
//        switch weekDay {
//        case "Monday":
//            dayName = "Пн"
//            print(dayName)
//            selectedIndex = 0
//            break
//        case "Tuesday":
//            dayName = "Вт"
//            print(dayName)
//            selectedIndex = 1
//            break
//        case "Wednesday":
//            dayName = "Ср"
//            print(dayName)
//            selectedIndex = 2
//            break
//        case "Thursday":
//            dayName = "Чт"
//            print(dayName)
//            selectedIndex = 3
//            break
//        case "Friday":
//            dayName = "Пт"
//            print(dayName)
//            selectedIndex = 4
//            break
//        case "Saturday":
//            dayName = "Сб"
//            print(dayName)
//            selectedIndex = 5
//            break
//        case "Sunday":
//            dayName = "Вс"
//            print(dayName)
//            selectedIndex = 6
//            break
//        default:
//            break
//        }
//        
//        var sevenDaysToShow: [String] = []
//        sevenDaysToShow.removeAll()
//        for index in 0..<7 {
//            let newIndex = index - selectedIndex
//            sevenDaysToShow.append(self.getDates(i: newIndex, currentDate: date ?? Date.today).0)
//        }
//        
//        //Month selection
//        let monthToSelectFrom = sevenDaysToShow[3]
//        let dateFormatterMonth = DateFormatter()
//        dateFormatterMonth.locale = Locale(identifier: "ru_RU_POSIX")
//        dateFormatterMonth.dateFormat = "dd-MM-yyyy"
//        let monthDate = dateFormatterMonth.date(from: monthToSelectFrom)!
//        
//        let dateFormatterMonthSecond = DateFormatter()
//        dateFormatterMonthSecond.dateFormat = "MMM, yyyy"
//        let month = dateFormatterMonthSecond.string(from: monthDate)
//        self.monthToShow = month
//        
//        self.lastDateInArray = sevenDaysToShow.last ?? ""
//        self.firstDayInArray = sevenDaysToShow.first ?? ""
//        self.sevenDates = sevenDaysToShow
//    }
//    
//    func getDates(i: Int, currentDate: Date) -> (String, String) {
//        let dateFormatter = DateFormatter()
//        dateFormatter.locale = Locale(identifier: "ru_RU")
//        var date = currentDate
//        let cal = Calendar.current
//        date = cal.date(byAdding: .day, value: i, to: date)!
//        dateFormatter.dateFormat = "dd-MM-yyyy"
//        let stringFormateFirst = dateFormatter.string(from: date)
//        dateFormatter.dateFormat = "dd-MM-yyyy"
//        let stringFormateSecond = dateFormatter.string(from: date)
//        return (stringFormateFirst, stringFormateSecond)
//    }
//}
//
//
//extension HorizontalCalendarView {
//     func getNextSevenDays(CompelitionHadnler: @escaping (String) -> Void) {
//        let selectedDataString = self.lastDateInArray
//        let dateFormatter = DateFormatter()
//        dateFormatter.locale = Locale(identifier: "ru_RU")
//        dateFormatter.dateFormat = "dd-MM-yyyy"
//        let date = dateFormatter.date(from: selectedDataString)!
//        var sevenDaysToShow: [String] = []
//        sevenDaysToShow.removeAll()
//        for index in 1...7 {
//            sevenDaysToShow.append(self.getDates(i: index, currentDate: date).0)
//        }
//        
//        //Month selection
//        let monthToSelectFrom = sevenDaysToShow[3]
//        let dateFormatterMonth = DateFormatter()
//        dateFormatterMonth.locale = Locale(identifier: "ru_RU")
//        dateFormatterMonth.dateFormat = "dd-MM-yyyy"
//        let monthDate = dateFormatterMonth.date(from: monthToSelectFrom)!
//        
//        let dateFormaterMonthSecond = DateFormatter()
//        dateFormaterMonthSecond.dateFormat = "MMMM, yyyy"
//        let month = dateFormaterMonthSecond.string(from: monthDate)
//        self.monthToShow = month
//        
//        self.lastDateInArray = sevenDaysToShow.last ?? ""
//        self.firstDayInArray = sevenDaysToShow.first ?? ""
//        self.sevenDates = sevenDaysToShow
//        return CompelitionHadnler("succes")
//    }
//    
//    func getPreviousSevenDays(CompelitionHandler: @escaping (String) -> Void) {
//        let selectedDataInString = self.firstDayInArray
//        let dateFormatter = DateFormatter()
//        dateFormatter.locale = Locale(identifier: "ru_RU")
//        dateFormatter.dateFormat = "dd-MM-yyyy"
//        let date = dateFormatter.date(from: selectedDataInString)!
//        var sevenDaysToShow: [String] = []
//        sevenDaysToShow.removeAll()
//        var count = 7
//        while count != 0 {
//            sevenDaysToShow.append(self.getDates(i: -count, currentDate: date).0)
//            count -= 1
//        }
//        
//        //Month Secelction
//        let monthToSelectFrom = sevenDaysToShow[3]
//        let dateFormatterMonth = DateFormatter()
//        dateFormatterMonth.locale = Locale(identifier: "ru_RU")
//        dateFormatterMonth.dateFormat = "dd-MM-yyyy"
//        let monthDate = dateFormatterMonth.date(from: monthToSelectFrom)!
//        
//        let dateFormatterMonthSecond = DateFormatter()
//        dateFormatterMonthSecond.locale = Locale(identifier: "ru_RU")
//        dateFormatterMonthSecond.dateFormat = "MMMM, yyyy"
//        let month = dateFormatterMonth.string(from: monthDate)
//        self.monthToShow = month
//        
//        self.lastDateInArray = sevenDaysToShow.last ?? ""
//        self.firstDayInArray = sevenDaysToShow.first ?? ""
//        self.sevenDates = sevenDaysToShow
//        return CompelitionHandler("succes")
//    }
//}
//
//extension HorizontalCalendarView {
//    func preformGesture() {
//        let leftGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipes(sender:)))
//        let rightGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipes(sender:)))
//        
//        leftGesture.direction = .left
//        rightGesture.direction = .right
//        
//        self.calendarView.addGestureRecognizer(leftGesture)
//        self.calendarView.addGestureRecognizer(rightGesture)
//    }
//    
//    func swipeTransitionToLeftSide(_ leftSide: Bool) -> CATransition {
//        let transition = CATransition()
//        transition.startProgress = 0.0
//        transition.endProgress = 1.0
//        transition.type = CATransitionType.push
//        transition.subtype = leftSide ? CATransitionSubtype.fromRight : CATransitionSubtype.fromLeft
//        transition.duration = 0.3
//        return transition
//    }
//    
//    @objc func handleSwipes(sender: UISwipeGestureRecognizer) {
//        if (sender.direction == .left) {
//            self.getNextSevenDays { [weak self] (response) in
//                if response == "succes" {
//                    DispatchQueue.main.async  {
//                        self?.calendarView.layer.add(self!.swipeTransitionToLeftSide(true), forKey: nil)
//                        self?.calendarView.collectionViewLayout.invalidateLayout()
//                        self?.calendarView.layoutSubviews()
//                        self?.calendarView.reloadData()
//                        //TODO - Make a month name change
//                    }
//                }
//            }
//        }
//        
//        if (sender.direction == .right) {
//            self.getPreviousSevenDays { [weak self] (response) in
//                if response == "succes" {
//                    self?.calendarView.layer.add(self!.swipeTransitionToLeftSide(false), forKey: nil)
//                    self?.calendarView.collectionViewLayout.invalidateLayout()
//                    self?.calendarView.layoutSubviews()
//                    self?.calendarView.reloadData()
//                    //TODO - Make a month name change
//                }
//            }
//        }
//    }
//}
