//
//  ToDosDetailController.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 02.04.2024.
//

import UIKit

final class ToDosDetailController: SingleToDoController {
    var item: ToDoObject?
    private var isEditButtonIsTapped: [String : Bool] = ["isTapped" : false]
    var presenter: ToDosDetailPresenterProtocol?
    
    //MARK: - Controller custom outlets
    private lazy var taskName: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        textView.adjustsFontForContentSizeCategory = true
        textView.textColor = .systemBackground
        textView.backgroundColor = UIColor(named: "coralColor")
        textView.isScrollEnabled = false
        textView.isUserInteractionEnabled = false
        return textView
    }()
    
    private lazy var editButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        button.backgroundColor = UIColor(named: "customBlue")
        button.tintColor = .systemBackground
        button.layer.cornerRadius = 35
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(editToDo), for: .touchDown)
        return button
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.backgroundColor = .systemRed
        button.tintColor = .systemBackground
        button.layer.cornerRadius = 35
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(deleteToDo), for: .touchDown)
        return button
    }()
    
    //MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
        tabBarController?.tabBar.isHidden = true
        self.navigationController?.addCustomBackButton()
        NotificationCenter.default.addObserver(self, selector: #selector(changeEditButtonState), name: Notification.Name(rawValue: "TapEditButton"), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdateTables"), object: nil)
    }
    
    //MARK: - Setup Hierarchy
    override func setupHierarchy() {
        view.addSubview(taskName)
        view.addSubview(descriptionText)
        view.addSubview(dateStack)
        dateStack.addArrangedSubview(dateLabel)
        dateStack.addArrangedSubview(datePicker)
        view.addSubview(categoryLabel)
        view.addSubview(categoryTableView)
        view.addSubview(editButton)
        view.addSubview(deleteButton)
    }
    
    //MARK: - Setup Layout
    override func setupLayout() {
        taskName.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(10)
        }
        
        descriptionText.snp.makeConstraints { make in
            make.top.equalTo(taskName.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(UIScreen.main.bounds.height / 7)
        }
        
        dateStack.snp.makeConstraints { make in
            make.top.equalTo(descriptionText.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(30)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(dateStack.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(30)
        }
        
        categoryTableView.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(30)
            make.bottom.equalTo(editButton.snp.top).inset(10)
        }
        
        editButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(40)
            make.leading.equalToSuperview().offset(30)
            make.width.height.equalTo(70)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(40)
            make.trailing.equalToSuperview().inset(30)
            make.width.height.equalTo(70)
        }
    }
    
    //MARK: - Setup Outlets
    override func setupOutlets() {
        categoryTableView.delegate = self
        setupUserInteracton(with: isEditButtonIsTapped["isTapped"] ?? false)
    }
    
    //MARK: - Setup TextView
    override func setupTextView() {
        descriptionText.text = item?.descriptionTitle
        descriptionText.textColor = .label
        descriptionText.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        descriptionText.returnKeyType = .done
        descriptionText.text = item?.descriptionTitle ?? "Описание задачи не установлено"
    }
    
    //MARK: - Button's Actions
    @objc private func changeEditButtonState(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let isTapped = userInfo["isTapped"] as? Bool else { return }
        if isTapped {
            editButton.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            editButton.backgroundColor = .systemGreen
            editButton.addTarget(self, action: #selector(saveEditToDo), for: .touchDown)
        } else {
            editButton.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
            editButton.backgroundColor = .systemOrange
            editButton.addTarget(self, action: #selector(editToDo), for: .touchDown)
        }
    }
    
    @objc func editToDo() {
        self.isEditButtonIsTapped["isTapped"] = true
        NotificationCenter.default.post(name: Notification.Name(rawValue: "TapEditButton"), object: nil, userInfo: self.isEditButtonIsTapped)
        setupUserInteracton(with: isEditButtonIsTapped["isTapped"] ?? true)
        taskName.isUserInteractionEnabled = true
    }
    
    @objc private func saveEditToDo() {
        self.isEditButtonIsTapped["isTapped"] = false
        NotificationCenter.default.post(name: Notification.Name(rawValue: "TapEditButton"), object: nil, userInfo: self.isEditButtonIsTapped)
        presenter?.editToDo(title: taskName.text, descriprion: descriptionText.text, date: datePicker.date, color: self.color ?? .systemPurple, iconName: self.iconName ?? "moon.fil")
        setupUserInteracton(with: isEditButtonIsTapped["isTapped"] ?? false)
        taskName.isUserInteractionEnabled = true
    }
    
    @objc func deleteToDo() {
        guard let task = item else { return }
        presenter?.whantDeleteToDo(task)
    }
}

    //MARK: - ToDosDetailViewProtocol
extension ToDosDetailController: ToDosDetailViewProtocol {
    func showToDoItem(_ toDo: ToDoObject) {
        self.item = toDo
        DispatchQueue.main.async {
            self.taskName.text = toDo.title
            self.descriptionText.text = toDo.descriptionTitle
            self.datePicker.date = toDo.date ?? Date.today
        }
        switch item?.color {
        case .systemOrange:
            categoryTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .none)
        case .taskGreen:
            categoryTableView.selectRow(at: IndexPath(row: 1, section: 0), animated: false, scrollPosition: .none)
        case .systemPurple:
            categoryTableView.selectRow(at: IndexPath(row: 2, section: 0), animated: false, scrollPosition: .none)
        default:
            break
        }
    }
}

    //MARK: - TableView Delegate extension
extension ToDosDetailController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let categories = TaskCategoryManager.manager.fetchCategories()
        let category = categories[indexPath.row]
        self.setupColorAndIcon(color: category.color, icon: category.iconName)
    }
}

