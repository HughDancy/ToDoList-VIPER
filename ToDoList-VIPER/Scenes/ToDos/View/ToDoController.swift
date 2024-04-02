//
//  ToDoController.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 25.03.2024.
//

import UIKit
import SnapKit

final class ToDoController: UIViewController {

    //MARK: - Properties
    var presenter: ToDosPresenterProtocol?
    private let calendarModel = CalendarModel()
    private var centerDate = Date()
    private var selectedDate = String()
    
    private var toDoTasks: [ToDoObject] = [] {
        didSet {
            toDoTable.reloadData()
        }
    }
        
    //MARK: - Outlets
    private lazy var calendarView: HorizontalCalendarView = {
        let calendar = HorizontalCalendarView()
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
        DispatchQueue.main.async {
            self.getCurrentDay()
            let calendarModel = CalendarModel()
            let daysArray = calendarModel.getWeekForCalendar(date: self.centerDate)
            self.calendarView.calendar.setDaysArray(days: daysArray)
            self.calendarView.calendar.selectedDate = DateFormatter.getStringFromDate(from: self.centerDate)
            self.calendarView.calendar.scrollToItem(at: [0, 10], at: .centeredHorizontally, animated: false)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        updateData(day: 0, index: 10)
        setupHierarchy()
        setupLayot()
        calendarView.calendar.calendarDelegate = self
        setupNotificationObserver()
        self.navigationController?.navigationBar.topItem?.title = "Назад"
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.navigationBar.prefersLargeTitles = false 
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
            make.leading.trailing.equalToSuperview().inset(8)
            make.height.equalTo(130)
        }
        
        toDoTable.snp.makeConstraints { make in
            make.top.equalTo(calendarView.snp.bottom).offset(15)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    //MARK: - Update calendar func
    private func updateData(day offset: Int, index: Int, scrollToItem: Bool = true) {
        centerDate = centerDate.getDayOffset(with: offset)
        let daysArray = calendarModel.getWeekForCalendar(date: centerDate)
        guard daysArray.count > index else { return }
        
        calendarView.calendar.setDaysArray(days: daysArray)
        calendarView.calendar.reloadData()
        calendarView.setupMonthLabel(with: daysArray[index].monthName.changeWordEnding().capitalized)
        
        guard scrollToItem else { return }
        calendarView.calendar.scrollToItem(at: [0, 10], at: .centeredHorizontally, animated: false)
    }
    
    //MARK: - Current date configure for start module
    private func getCurrentDay() {
        switch presenter?.date {
        case .today:
            self.centerDate = Date.today
        case .tommorow:
            self.centerDate = Date.tomorrow
        default:
            self.centerDate = Date.tomorrow
        }
    }
    
    //MARK: - Make notification observers for update collection
    private func setupNotificationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateTables), name: Notification.Name(rawValue: "UpdateTables"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(makeItDone), name: Notification.Name(rawValue: "DoneTask") , object: nil)
    }
    
    @objc func updateTables(notification: Notification) {
        DispatchQueue.main.async {
            self.presenter?.updateToDosForDay(self.selectedDate)
            self.toDoTable.reloadData()
            let calendarModel = CalendarModel()
            let daysArray = calendarModel.getWeekForCalendar(date: self.centerDate)
            self.calendarView.calendar.setDaysArray(days: daysArray)
            self.calendarView.calendar.reloadData()
        }
    }
    
    @objc func makeItDone(notification: Notification) {
        guard let doneInfo = notification.userInfo else { return }
        guard let item = doneInfo["doneItem"] as? ToDoObject else { return }
        self.presenter?.doneToDo(item)
    }
    
    func makeNotification() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdateTables"), object: nil)
    }
}

//MARK: - TableView Extension
extension ToDoController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ToDoCell.reuseIdentifier, for: indexPath) as? ToDoCell
        cell?.setupCell(with: toDoTasks[indexPath.row])
        tableView.reloadRows(at: [indexPath], with: .none)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "") { _, _, _ in
            tableView.dataSource?.tableView?(tableView, commit: .delete, forRowAt: indexPath)
        }
        action.image = UIGraphicsImageRenderer(size: CGSize(width: 50, height: 74)).image { _ in
            UIImage(named: "delete")?.draw(in: CGRect(x: 0, y: 0, width: 50, height: 74))
        }
        
        action.backgroundColor = .systemBackground
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = toDoTasks[indexPath.row]
        print(item)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            presenter?.deleteToDo(toDoTasks[indexPath.row])
            toDoTasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
            self.makeNotification()
            tableView.endUpdates()
        }
    }
}


//MARK: - Calendar Support methods extension
extension ToDoController: CalendarCollectionViewDelegate {
    func scrollLeft() {
        updateData(day: -7, index: 7)
    }
    
    func scrollRight() {
        updateData(day: 7, index: 13)
    }
    
    func updateTasks(with data: String) {
        presenter?.updateToDosForDay(data)
        self.selectedDate = data
        toDoTable.reloadData()
    }
}

//MARK: - ToDosViewProtocol extension
extension ToDoController: ToDosViewProtocol {
    func fetchToDos(date: Date) {
        presenter?.fetchToDos(date: date)
    }
    
    func showToDos(_ toDos: [ToDoObject]) {
        self.toDoTasks = toDos
    }
}


