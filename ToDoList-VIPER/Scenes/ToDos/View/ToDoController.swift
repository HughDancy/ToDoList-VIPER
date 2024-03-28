//
//  ToDoController.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 25.03.2024.
//

import UIKit
import SnapKit

final class ToDoController: UIViewController {
    
    
    //MARK: - Outlets
    private lazy var calendarView: HorizontalCalendarView = {
        let calendar = HorizontalCalendarView()
        calendar.calendar.delegate = self
        calendar.calendar.dataSource = self
//        calendar.calendarView.register(CalendarCollectionCell.self, forCellWithReuseIdentifier: CalendarCollectionCell.reuseIdentifier)
        return calendar
    }()
    
    private lazy var toDoTable: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .systemBackground
        tableView.register(ToDoCell.self, forCellReuseIdentifier: ToDosCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        return tableView
    }()
    
    //MARK: - Lifecycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        calendarView.calendar.scrollToItem(at: [0, 10], at: .centeredHorizontally, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupHierarchy()
        setupLayot()
        calendarView.calendar.calendarDelegate = self
        
    }
    
    //MARK: - Setup Hierarchy
    private func setupHierarchy() {
        view.addSubview(calendarView)
        view.addSubview(toDoTable)
    }
    
    //MARK: - Setup Layout
    private func setupLayot() {
        calendarView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(5)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
        
        toDoTable.snp.makeConstraints { make in
            make.top.equalTo(calendarView.snp.bottom).offset(15)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    //MARK: - Update func
    private func updateData(day offset: Int, index: Int, scrollToItem: Bool = true) {
        let calendarModel = CalendarModel()
        let date = Date()
        let centerDay = date.getDayOffset(with: offset)
        let daysArray = calendarModel.getWeekForCalendar(date: centerDay)
        guard daysArray.count > index else { return }
        
        calendarView.calendar.setDaysArray(days: daysArray)
        calendarView.calendar.reloadData()
        calendarView.setupMonthLabel(with: daysArray[index].monthName.changeWordEnding().capitalized)
        
        guard scrollToItem else { return }
        calendarView.calendar.scrollToItem(at: [0, 10], at: .centeredHorizontally, animated: false)
        print("Update calendar func is working")
    }
}

//MARK: - TableView Extension
extension ToDoController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ToDoItems.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ToDoCell.reuseIdentifier, for: indexPath) as? ToDoCell
        cell?.setupCell(with: ToDoItems.items[indexPath.row].title,
                        boxColor: ToDoItems.items[indexPath.row].color,
                        icon: ToDoItems.items[indexPath.row].nameOfImage)
        return cell ?? UITableViewCell()
    }
}

//MARK: - CollectionView Delegate Extension
extension ToDoController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let calendarModel = CalendarModel()
        let date = Date()
//        let centerDay = date.getDayOffset(with: 1)
        let daysArray = calendarModel.getWeekForCalendar(date: Date.today)
        return daysArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = calendarView.calendar.frame.width / 7.7
        let height = calendarView.calendar.frame.height
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCollectionCell.reuseIdentifier, for: indexPath) as! CalendarCollectionCell
        
//        cell.setupCell(dayOfWeek: calendarView.dayName, numberOfDay: calendarView.sevenDates[indexPath.row])
        let calendarModel = CalendarModel()
        let date = Date()
        let centerDay = date.getDayOffset(with: 3)
        let daysArray = calendarModel.getWeekForCalendar(date: centerDay)
        cell.setupCell(daysArray[indexPath.row])
        calendarView.setupMonthLabel(with: daysArray[indexPath.row].monthName.changeWordEnding().capitalized)
        
        if indexPath.row == calendarView.calendar.selectedUserCell {
            collectionView
                .selectItem(at: [0, calendarView.calendar.selectedUserCell], animated: false, scrollPosition: [])
        }
//        if daysArray[indexPath.row].dateString == DateFormatter.createMediumDate(from: Date.today) {
//            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
//        }
      
        return cell /*?? UICollectionViewCell()*/
    }
    
    
}

//MARK: - Calendar Support methods extension
extension ToDoController: CalendarCollectionViewDelegate {
    func scrollLeft() {
        updateData(day: -7, index: 7)
    }
    
    func scrollRight() {
        updateData(day: -7, index: 13)
    }
    
   
}

struct ToDoItems {
    var title: String
    var color: UIColor
    var nameOfImage: String
}

extension ToDoItems {
    static let items = [
        ToDoItems(title: "working on code",
                  color: .systemOrange,
                  nameOfImage: "bag"),
        ToDoItems(title: "good sleep",
                  color: .systemGreen,
                  nameOfImage: "person"),
        ToDoItems(title: "buy Nintendo",
                  color: .systemPurple,
                  nameOfImage: "folder"),
        ToDoItems(title: "working on code twice",
                  color: .systemOrange,
                  nameOfImage: "bag")
    ]
}



//extension ToDoController {
//    func preformGesture() {
//        let leftGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipes(sender:)))
//        let rightGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipes(sender:)))
//        
//        leftGesture.direction = .left
//        rightGesture.direction = .right
//        
//        self.calendarView.calendarView.addGestureRecognizer(leftGesture)
//        self.calendarView.calendarView.addGestureRecognizer(rightGesture)
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
//            calendarView.getNextSevenDays { [weak self] (response) in
//                if response == "succes" {
//                    DispatchQueue.main.async  {
//                        self?.calendarView.calendarView.layer.add(self!.swipeTransitionToLeftSide(true), forKey: nil)
//                        self?.calendarView.calendarView.collectionViewLayout.invalidateLayout()
//                        self?.calendarView.calendarView.layoutSubviews()
//                        self?.calendarView.calendarView.reloadData()
//                        //TODO - Make a month name change
//                    }
//                }
//            }
//        }
//        
//        if (sender.direction == .right) {
//            self.calendarView.getPreviousSevenDays { [weak self] (response) in
//                if response == "succes" {
//                    self?.calendarView.calendarView.layer.add(self!.swipeTransitionToLeftSide(false), forKey: nil)
//                    self?.calendarView.calendarView.collectionViewLayout.invalidateLayout()
//                    self?.calendarView.calendarView.layoutSubviews()
//                    self?.calendarView.calendarView.reloadData()
//                    //TODO - Make a month name change
//                }
//            }
//        }
//    }
//}
