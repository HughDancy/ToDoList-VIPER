//
//  ToDoController.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 25.03.2024.
//

import UIKit

final class ToDoController: UIViewController {

    //MARK: - Properties
    var presenter: ToDosPresenterProtocol?
    private let calendarModel = CalendarModel()
    private var selectedDate = Date()
    
    private var toDoTasks: [ToDoObject] = [] {
        didSet {
            if toDoTasks.count == 0 {
                mainView?.noTaskView.isHidden = false
            } else {
                mainView?.noTaskView.isHidden = true
            }
        }
    }
    
    private var mainView: ToDosView? {
        guard isViewLoaded else { return nil }
        return view as? ToDosView
    }
    
    //MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.addCustomBackButton()
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = ToDosView(status: presenter?.status)
        setupView()
    }
    
    deinit {
        print("ToDoController is ☠️")
    }
    
    //MARK:  - Setup View
    private func setupView() {
        presenter?.getToDos()
        self.getCurrentDate()
        setupCalendarColletcion()
        view.backgroundColor = UIColor(named: "tasksBackground")
        setupOtlets()
        setupNavigationBar()
    }
    
    //MARK: - Setup outlets
    private func setupOtlets() {
        updateData(day: 0, index: 10)
        mainView?.tasksLabel.status = presenter?.status ?? .today
        mainView?.calendarView.calendar.calendarDelegate = self
        setupNotificationObserver()
        setupNoTaskStack()
        mainView?.toDoTable.delegate = self
        mainView?.toDoTable.dataSource = self
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func setupCalendarColletcion() {
        DispatchQueue.main.async {
            let calendarModel = CalendarModel()
            let daysArray = calendarModel.getWeekForCalendar(date: self.selectedDate)
            self.mainView?.calendarView.calendar.setDaysArray(days: daysArray)
            self.mainView?.calendarView.calendar.scrollToItem(at: [0, 10], at: .centeredHorizontally, animated: false)
        }
    }
    
    private func setupNavigationBar() {
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    //MARK: - Current date configure for start module
    private func getCurrentDate() {
        switch presenter?.status {
        case .today, .done:
            defaultCalendarSetup(date: Date.today)
        case .tommorow:
            defaultCalendarSetup(date: Date.tomorrow)
        case .overdue:
            defaultCalendarSetup(date: Date.yesterday)
        default:
            self.selectedDate = Date.tomorrow
        }
    }
    
    private func defaultCalendarSetup(date: Date) {
        self.selectedDate = date
        mainView?.calendarView.calendar.centerDate = date
    }

    //MARK: - No tasks setup method
    private func setupNoTaskStack() {
        if toDoTasks.count == 0 {
            mainView?.noTaskView.isHidden = false
        } else {
            mainView?.noTaskView.isHidden = true
        }
    }
}

    //MARK: - TableView Data Source Extension
extension ToDoController:  UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ToDoCell.reuseIdentifier, for: indexPath) as? ToDoCell else  {
            return UITableViewCell()
        }
        cell.setupCell(with: toDoTasks[indexPath.row], status: self.presenter?.status ?? ToDoListStatus.tommorow)
        return cell
    }
}

    //MARK: - TableView Delegate Extension
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
            presenter?.deleteToDo(itemToDelete.id ?? UUID.init())
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
            self.mainView?.toDoTable.reloadData()
            self.updateCalendar()
        }
    }
    
    private func updateCalendar() {
        let calendarModel = CalendarModel()
        let daysArray = calendarModel.getWeekForCalendar(date: selectedDate)
        mainView?.calendarView.calendar.setDaysArray(days: daysArray)
        mainView?.calendarView.calendar.scrollToItem(at: [0, 10], at: .centeredHorizontally, animated: false)
    }
    
    
    @objc func makeItDone(notification: Notification) {
        guard let doneInfo = notification.userInfo else { return }
        guard let taskId = doneInfo["taskID"] as? UUID else { return }
        self.presenter?.doneToDo(taskId)
        guard let index = toDoTasks.firstIndex(where: { $0.id == taskId }) else { return }
        let doneItem = toDoTasks.remove(at: index)
        toDoTasks.append(doneItem)
        mainView?.toDoTable.reloadData()
        NotificationCenter.default.post(name: NotificationNames.updateMainScreen.name, object: nil)
    }
}

//MARK: - Calendar Support methods extension
extension ToDoController: CalendarCollectionViewDelegate {
    func scrollLeft() {
        DispatchQueue.main.async {
            self.updateData(day: -7, index: 7)
        }
    }
    
    func scrollRight() {
        DispatchQueue.main.async {
            self.updateData(day: 7, index: 13)
        }
    }

    private func updateData(day offset: Int, index: Int, scrollToItem: Bool = true) {
        selectedDate = selectedDate.getDayOffset(with: offset)
        mainView?.calendarView.calendar.centerDate = self.selectedDate
        let daysArray = calendarModel.getWeekForCalendar(date: selectedDate)
        guard daysArray.count > index else { return }
        
        mainView?.calendarView.calendar.setDaysArray(days: daysArray)
        mainView?.calendarView.calendar.reloadData()
        mainView?.calendarView.setupMonthLabel(with: daysArray[index].monthName.changeWordEnding().capitalized)
        
        guard scrollToItem else { return }
        mainView?.calendarView.calendar.scrollToItem(at: [0, 10], at: .centeredHorizontally, animated: false)
    }
    
    func updateTasks(with data: Date) {
        self.selectedDate = data
        presenter?.updateToDosForDay(data)
        mainView?.toDoTable.reloadData()
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


