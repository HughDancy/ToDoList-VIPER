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
    private var selectedDate = Date()
    
    private var toDoTasks: [ToDoObject] = [] {
        didSet {
            if toDoTasks.count == 0 {
                noTaskView.isHidden = false
            } else {
                noTaskView.isHidden = true
            }
        }
    }
        
    //MARK: - Outlets
    private lazy var calendarView: HorizontalCalendarView = {
        let calendar = HorizontalCalendarView()
        return calendar
    }()
    
    private lazy var toDoTable: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = UIColor(named: "tasksBackground")
        tableView.register(ToDoCell.self, forCellReuseIdentifier: ToDoCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    private lazy var taskImage: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "noTasks")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var tasksLabel = NoTaskLabel(status: presenter?.date ?? .today, size: 25, weight: .bold, color: .white)
    
    private lazy var noTaskView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    //MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.addCustomBackButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    deinit {
        print("ToDoController is ☠️")
    }
    
    //MARK:  - Setup View
    private func setupView() {
        presenter?.viewWillAppear()
        self.getCurrentDay()
        setupCalendarColletcion()
        view.backgroundColor = UIColor(named: "tasksBackground")
        setupOtlets()
        setupNavigationBar()
    }
    
    //MARK: - Setup outlets
    private func setupOtlets() {
        updateData(day: 0, index: 10)
        setupHierarchy()
        setupLayot()
        calendarView.calendar.calendarDelegate = self
        setupNotificationObserver()
        setupNoTaskStack()
    }
    
    private func setupCalendarColletcion() {
        DispatchQueue.main.async {
            let calendarModel = CalendarModel()
            let daysArray = calendarModel.getWeekForCalendar(date: self.selectedDate)
            self.calendarView.calendar.setDaysArray(days: daysArray)
            self.calendarView.calendar.scrollToItem(at: [0, 10], at: .centeredHorizontally, animated: false)
        }
    }
    
    private func setupNavigationBar() {
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    //MARK: - Setup Hierarchy
    private func setupHierarchy() {
        view.addSubview(calendarView)
        view.addSubview(toDoTable)
        view.addSubview(noTaskView)
        noTaskView.addSubview(taskImage)
        noTaskView.addSubview(tasksLabel)
    }
    
    //MARK: - Setup Layout
    private func setupLayot() {
        noTaskView.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(300)
            make.width.equalTo(270)
        }
        
        taskImage.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(noTaskView).inset(10)
        }
        
        tasksLabel.snp.makeConstraints { make in
            make.top.equalTo(taskImage.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(1)
        }
        
        tasksLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(5)
        }
        
        calendarView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(5)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(130)
        }
        
        toDoTable.snp.makeConstraints { make in
            make.top.equalTo(calendarView.snp.bottom).offset(15)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    //MARK: - Current date configure for start module
    private func getCurrentDay() {
        switch presenter?.date {
        case .today, .done:
            setupCalendarDefault(date: Date.today)
        case .tommorow:
            setupCalendarDefault(date: Date.tomorrow)
        case .overdue:
            setupCalendarDefault(date: Date.yesterday)
        default:
            self.selectedDate = Date.tomorrow
        }
    }
    
    private func setupCalendarDefault(date: Date) {
        self.selectedDate = date
        self.calendarView.calendar.centerDate = date
    }

    //MARK: - No tasks setup method
    private func setupNoTaskStack() {
        if toDoTasks.count == 0 {
            noTaskView.isHidden = false
        } else {
            noTaskView.isHidden = true
        }
    }
}

//MARK: - TableView Extension
extension ToDoController:  UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ToDoCell.reuseIdentifier, for: indexPath) as? ToDoCell else  {
            return UITableViewCell()
        }
        cell.setupCell(with: toDoTasks[indexPath.row], status: self.presenter?.date ?? ToDoListStatus.tommorow)
        return cell
    }
}

extension ToDoController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let toDo = toDoTasks[indexPath.row]
        presenter?.goToTask(toDo)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "") { _, _, _ in
            tableView.dataSource?.tableView?(tableView, commit: .delete, forRowAt: indexPath)
        }
        action.image = UIGraphicsImageRenderer(size: CGSize(width: 50, height: 74)).image { some in
            UIImage(named: "delete")?.draw(in: CGRect(x: 0, y: 0, width: 50, height: 74))
        }
        
        action.backgroundColor = UIColor(named: "tasksBackground")
        return UISwipeActionsConfiguration(actions: [action])
    }

    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let itemToDelete = toDoTasks[indexPath.row]
            presenter?.deleteToDo(itemToDelete)
            tableView.beginUpdates()
            toDoTasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .right)
            tableView.endUpdates()
            self.updateCalendar()
            self.setupNoTaskStack()
        }
    }
}

    //MARK: - Make notification observers for update tableView and CalendarCollection Extension
extension ToDoController {
    private func setupNotificationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateTables), name: NotificationNames.updateTables.name, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(makeItDone), name: NotificationNames.doneToDo.name , object: nil)
    }
    
    @objc func updateTables(notification: Notification) {
        DispatchQueue.main.async {
            self.presenter?.updateToDosForDay(self.selectedDate)
            self.toDoTable.reloadData()
            self.updateCalendar()
            self.tabBarController?.tabBar.isHidden = false
        }
    }
    
    private func updateCalendar() {
        let calendarModel = CalendarModel()
        let daysArray = calendarModel.getWeekForCalendar(date: selectedDate)
        self.calendarView.calendar.setDaysArray(days: daysArray)
    }
    
    
    @objc func makeItDone(notification: Notification) {
        guard let doneInfo = notification.userInfo else { return }
        guard let item = doneInfo["doneItem"] as? ToDoObject else { return }
        self.presenter?.doneToDo(item)
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

    private func updateData(day offset: Int, index: Int, scrollToItem: Bool = true) {
        let centerDate = selectedDate.getDayOffset(with: offset)
        let daysArray = calendarModel.getWeekForCalendar(date: centerDate)
        guard daysArray.count > index else { return }
        
        calendarView.calendar.setDaysArray(days: daysArray)
        calendarView.calendar.reloadData()
        calendarView.setupMonthLabel(with: daysArray[index].monthName.changeWordEnding().capitalized)
        
        guard scrollToItem else { return }
        calendarView.calendar.scrollToItem(at: [0, 10], at: .centeredHorizontally, animated: false)
    }
    
    func updateTasks(with data: Date) {
        self.selectedDate = data
        presenter?.updateToDosForDay(data)
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


