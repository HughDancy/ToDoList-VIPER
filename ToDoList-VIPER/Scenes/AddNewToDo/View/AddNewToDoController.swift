//
//  AddNewToDoController.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 15.03.2024.
//

import UIKit

class AddNewToDoController: UIViewController {
    
    //MARK: - OUTLETS
    private lazy var titleOfScreen: UILabel = {
        let label = UILabel()
        label.text = "Добавить задачу"
        label.font = UIFont.systemFont(ofSize: 35, weight: .bold)
        label.textColor = .systemCyan
        return label
    }()
    
    private lazy var nameOfTaskField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.backgroundColor = .systemGray5
        textField.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        textField.placeholder = "Наименование задачи"
        textField.layer.cornerRadius = 10
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
        return textField
    }()
    
    private lazy var descriptionField: UITextView = {
       let textView = UITextView()
//        textView.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
//        textView.placeholderText = "Описание задачи"
        textView.backgroundColor = .systemGray5
        textView.layer.cornerRadius = 10
        
        return textView
    }()
 
    private lazy var dateField = UIDatePicker.createToDoPicker()
    private lazy var addNewToDoButton = UIButton.createToDoButton(title: "Add new ToDo", backColor: .systemCyan, tintColor: .systemBackground)
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupHierarchy()
        setupLayout()
    }
    
    //MARK: - Setup Hierarchy
    private func setupHierarchy() {
        view.addSubview(titleOfScreen)
        view.addSubview(nameOfTaskField)
        view.addSubview(descriptionField)
//        view.addSubview(dateField)
        view.addSubview(addNewToDoButton)
    }
    //MARK: - Setup Layout
    private func setupLayout() {
        titleOfScreen.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
        }
        
        nameOfTaskField.snp.makeConstraints { make in
            make.top.equalTo(titleOfScreen.snp.bottom).offset(50)
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalTo(50)
        }
        
        descriptionField.snp.makeConstraints { make in
            make.top.equalTo(nameOfTaskField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalTo(100)
        }
        
//        dateField.snp.makeConstraints { make in
//            make.top.equalTo(descriptionField.snp.bottom).offset(10)
//            make.leading.trailing.equalToSuperview().inset(40)
//        }
        
        addNewToDoButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(50)
            make.leading.trailing.equalToSuperview().inset(50)
            make.height.equalTo(50)
            
        }
        
        addNewToDoButton.layer.cornerRadius = 10
        
    }
    //MARK: - Button Action
    @objc func addNewToDo() {
        
    }
    
    @objc func removeTextInTextView() {
        self.descriptionField.text = ""
    }
    
    
}
