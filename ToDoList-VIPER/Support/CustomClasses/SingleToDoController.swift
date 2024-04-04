//
//  SingleToDoController.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 02.04.2024.
//

import UIKit

class SingleToDoController: UIViewController {
    var color: ColorsItemResult?
    
    //MARK: - Base Outelts
    lazy var descriptionText: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .systemGray6
        textView.layer.cornerRadius = 10
        textView.clipsToBounds = true
        return textView
    }()
    
    lazy var dateStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 10
        return stack
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Дата"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .systemBackground
        return label
    }()
    
    lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .compact
        picker.locale = Locale(identifier: "ru_RU")
        picker.backgroundColor = UIColor(named: "coralColor")
        return picker
    }()
    
    lazy var cathegoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Категория:"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .systemBackground
        return label
    }()
    
    lazy var cathegoryTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = UIColor(named: "coralColor")
        tableView.isScrollEnabled = false
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.register(CathegoryCell.self, forCellReuseIdentifier: CathegoryCell.reuseIdentifier)
        return tableView
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "coralColor")
        setupHierarchy()
        setupLayout()
        setupOutlets()
        setupTextView()
    }
    
    //MARK: - Setup Hierarchy
    func setupHierarchy() { }
    
    //MARK: - Setup Layout
    func setupLayout() { }
    
    //MARK: - Setup Outlets
    func setupOutlets() { }
    
    //MARK: - Setup TextView
    func setupTextView() { }

    //MARK: - Setup elements user interaction
    func setupUserInteracton(with bool: Bool) {
        descriptionText.isUserInteractionEnabled = bool
        datePicker.isUserInteractionEnabled = bool
        cathegoryTableView.isUserInteractionEnabled = bool
    }
}

//MARK: - TableView Data source extension
extension SingleToDoController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ColorsItem.colorsStack.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CathegoryCell.reuseIdentifier, for: indexPath) as? CathegoryCell
        let cathegoryName = ["Работа", "Личное", "Иное"]
        cell?.backgroundColor = UIColor(named: "coralColor")
        cell?.setupCell(with: ColorsItem.colorsStack[indexPath.row], title: cathegoryName[indexPath.row])
        return cell ?? UITableViewCell()
    }
}

