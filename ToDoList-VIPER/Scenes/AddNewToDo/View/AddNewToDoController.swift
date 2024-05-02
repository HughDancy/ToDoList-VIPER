//
//  AddNewToDoController.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 15.03.2024.
//

import UIKit

final class AddNewToDoController: SingleToDoController, AddNewToDoViewProtocol {
    var presenter: AddNewToDoPresenterProtocol?
    
    //MARK: - OUTLETS
    private lazy var closeButton: BaseButton = {
        let button = BaseButton(text: "", color: .systemRed)
        button.makeButtonCircle(with: 15)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.addTarget(self, action: #selector(dismissToMain), for: .touchDown)
        return button
    }()

    private lazy var titleOfScreen: UILabel = {
        let label = UILabel.createSimpleLabel(text: "Добавить задачу", size: 35, width: .bold, color: .systemBackground)
        return label
    }()
    
    private lazy var nameOfTaskField: UITextField = {
        let textField = UITextField.createToDoTextField(
            text: "Наименование задачи",
            textSize: 15,
            weight: .semibold,
            color: .systemGray6,
            returnKey: .done
        )
        textField.delegate = self
        return textField
    }()
    
    private lazy var addNewToDoButton: BaseButton = {
        let button = BaseButton(text: "Добавить задачу", color: UIColor(named: "customBlue") ?? .systemOrange)
        button.addTarget(self, action: #selector(addNewToDo), for: .touchDown)
        return button
    }()
    
    //MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        categoryTableView.delegate = self
    }
    
    //MARK: - Setup Hierarchy and Layout
    override func setupHierarchy() {
        view.addSubview(closeButton)
        view.addSubview(titleOfScreen)
        view.addSubview(nameOfTaskField)
        view.addSubview(descriptionText)
        view.addSubview(dateStack)
        dateStack.addArrangedSubview(dateLabel)
        dateStack.addArrangedSubview(datePicker)
        view.addSubview(categoryLabel)
        view.addSubview(categoryTableView)
        view.addSubview(addNewToDoButton)
    }
    
    override func setupLayout() {
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalToSuperview().offset(15)
            make.height.width.equalTo(30)
        }
        
        titleOfScreen.snp.makeConstraints { make in
            make.top.equalTo(closeButton.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        nameOfTaskField.snp.makeConstraints { make in
            make.top.equalTo(titleOfScreen.snp.bottom).offset((UIScreen.main.bounds.height / 13) - (UIScreen.main.bounds.width / 13))
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
        
        descriptionText.snp.makeConstraints { make in
            make.top.equalTo(nameOfTaskField.snp.bottom).offset(20)
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
            make.bottom.equalTo(addNewToDoButton.snp.top).inset(10)
        }
        
        addNewToDoButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(40)
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalTo(50)
        }
        
        addNewToDoButton.layer.cornerRadius = 20
    }
    
    //MARK: - Setup View Outelets
    override func setupTextView() {
        descriptionText.text = "Описание задачи"
        descriptionText.textColor = .lightGray
        descriptionText.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        
        descriptionText.delegate = self
        descriptionText.returnKeyType = .done
    }
    
    //MARK: - Buttons Action
    @objc func addNewToDo() {
        presenter?.addNewToDo(with: nameOfTaskField.text,
                              description: descriptionText.text,
                              date: datePicker.date,
                              colorCategory: color ?? .systemPurple,
                              iconName: self.iconName ?? "moon.fill")
        self.makeNotification()
    }
    
    @objc func dismissToMain() {
        presenter?.goBackToMain()
    }
    
    //MARK: - Notification
    func makeNotification() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdateTables"), object: nil)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdateMainScreenData"), object: nil)
    }
}

extension AddNewToDoController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let categories = TaskCategoryManager.manager.fetchCategories()
        let category = categories[indexPath.row]
        self.setupColorAndIcon(color: category.color, icon: category.iconName)
    }
}

    //MARK: - TextField Delegate
extension AddNewToDoController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameOfTaskField.resignFirstResponder()
        return true
    }
}

    //MARK: - UITextView Delegate
extension AddNewToDoController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if descriptionText.text == "Описание задачи"  {
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
            descriptionText.text = "Описание задачи"
            descriptionText.textColor = .lightGray
            descriptionText.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        }
    }
}
