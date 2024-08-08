//
//  ToDosView.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 22.07.2024.
//

import UIKit

final class ToDosView: UIView {
    var status: ToDoListStatus?
    // MARK: - Outlets
    lazy var calendarView: HorizontalCalendarView = {
        let calendar = HorizontalCalendarView()
        return calendar
    }()

    lazy var toDoTable: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = UIColor(named: "tasksBackground")
        tableView.register(ToDoCell.self, forCellReuseIdentifier: ToDoCell.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.accessibilityLabel = "ToDoTable"
        return tableView
    }()

    lazy var taskImage: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "noTasks")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    lazy var tasksLabel = NoTaskLabel(status: self.status ?? .today, size: 25, weight: .bold, color: .white)

    lazy var noTaskView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()

    // MARK: - Init
    init(status: ToDoListStatus?) {
        super.init(frame: .zero)
        self.status = status
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        setupHierarchy()
        setupLayout()
        self.backgroundColor = .systemBackground
    }

    // MARK: - Setup Hierarchy
    private func setupHierarchy() {
        self.addSubview(calendarView)
        self.addSubview(toDoTable)
        self.addSubview(noTaskView)
        noTaskView.addSubview(taskImage)
        noTaskView.addSubview(tasksLabel)
    }

    // MARK: - Setup Layout
    private func setupLayout() {
        noTaskView.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(self.safeAreaLayoutGuide)
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
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(5)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(130)
        }

        toDoTable.snp.makeConstraints { make in
            make.top.equalTo(calendarView.snp.bottom).offset(15)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
