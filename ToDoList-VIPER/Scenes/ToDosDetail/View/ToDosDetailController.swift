//
//  ToDosDetailController.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 02.04.2024.
//

import UIKit

final class ToDosDetailController: SingleToDoController {
    var item: ToDoObject?
    
    //MARK: - Controller custom outlets
    private lazy var taskName: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 45, weight: .bold)
        textView.textColor = .systemBackground
        textView.isScrollEnabled = false
        textView.isUserInteractionEnabled = false
        return textView
    }()
    
    private lazy var editButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Редактировать", for: .normal)
        button.backgroundColor = .systemOrange
        button.tintColor = .systemBackground
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(editToDo), for: .touchDown)
        return button
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Удалить", for: .normal)
        button.backgroundColor = .systemRed
        button.tintColor = .systemBackground
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(deleteToDo), for: .touchDown)
        return button
    }()
    
    //MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
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
        view.addSubview(cathegoryLabel)
        view.addSubview(cathegoryTableView)
        view.addSubview(editButton)
        view.addSubview(deleteButton)
    }
    
    //MARK: - Setup Layout
    override func setupLayout() {
        taskName.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
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
        
        cathegoryLabel.snp.makeConstraints { make in
            make.top.equalTo(dateStack.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(30)
        }
        
        cathegoryTableView.snp.makeConstraints { make in
            make.top.equalTo(cathegoryLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(30)
            make.bottom.equalTo(editButton.snp.top).inset(10)
        }
        
        editButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(40)
            make.leading.equalToSuperview().offset(30)
            make.width.equalTo(60)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(40)
            make.trailing.equalToSuperview().inset(30)
            make.width.equalTo(60)
        }
    }
    
    //MARK: - Setup Outlets
    override func setupOutlets() {
        cathegoryTableView.delegate = self
        self.taskName.text = item?.title
        self.descriptionText.text = item?.descriptionTitle
        self.datePicker.date = item?.date ?? Date.today
    }
    
    //MARK: - Setup TextView
    override func setupTextView() {
        descriptionText.text = item?.descriptionTitle
        descriptionText.textColor = .lightGray
        descriptionText.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        
        descriptionText.delegate = self
        descriptionText.returnKeyType = .done
    }
    
    //MARK: - Button's Actions
    @objc func editToDo() {
        
    }
    
    @objc func deleteToDo() {
        
    }
    
}

//MARK: - TableView Delegate extension
extension ToDosDetailController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch ColorsItem.colorsStack[indexPath.row] {
        case .systemOrange:
            self.color = ColorsItemResult.systemOrange
        case .systemGreen:
            self.color = ColorsItemResult.systemGreen
        case .systemPurple:
            self.color = ColorsItemResult.systemPurple
        default:
            self.color = ColorsItemResult.systemOrange
        }
    }
}

//MARK: - TextView Delegate Extension
extension ToDosDetailController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if descriptionText.text == item?.descriptionTitle  {
            descriptionText.text = ""
            textView.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
            textView.textColor = UIColor.label
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            descriptionText.resignFirstResponder()
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if descriptionText.text == "" {
            descriptionText.text = item?.descriptionTitle
            descriptionText.textColor = .lightGray
            descriptionText.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        }
    }
}

