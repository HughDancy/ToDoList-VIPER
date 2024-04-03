//
//  ToDosDetailController.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 02.04.2024.
//

import UIKit

final class ToDosDetailController: SingleToDoController {
    var item: ToDoObject?
    var isEditButtonIsTapped: [String : Bool] = ["isTapped" : false]
    
    //MARK: - Controller custom outlets
    private lazy var taskName: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 45, weight: .bold)
        textView.textColor = .systemBackground
        textView.backgroundColor = UIColor(named: "coralColor")
        textView.isScrollEnabled = false
        textView.isUserInteractionEnabled = false
        return textView
    }()
    
    private lazy var editButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
//        let saveEditImage = UIImage(systemName: "checkmark.circle")
//        button.setImage(UIImage(systemName: "checkmark.circle"), for: .selected)
        button.backgroundColor = .systemOrange
        button.tintColor = .systemBackground
        button.layer.cornerRadius = 30
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(editToDo), for: .touchDown)
        return button
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.backgroundColor = .systemRed
        button.tintColor = .systemBackground
        button.layer.cornerRadius = 30
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(deleteToDo), for: .touchDown)
        return button
    }()
    
    //MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
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
        view.addSubview(cathegoryLabel)
        view.addSubview(cathegoryTableView)
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
            make.width.height.equalTo(60)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(40)
            make.trailing.equalToSuperview().inset(30)
            make.width.height.equalTo(60)
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
        print("Edit is starting")
    }
    
    @objc private func saveEditToDo() {
        self.isEditButtonIsTapped["isTapped"] = false
        NotificationCenter.default.post(name: Notification.Name(rawValue: "TapEditButton"), object: nil, userInfo: self.isEditButtonIsTapped)
        print("Saving what been edited")
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

