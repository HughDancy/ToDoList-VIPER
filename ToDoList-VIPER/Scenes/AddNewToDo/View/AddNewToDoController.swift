//
//  AddNewToDoController.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 15.03.2024.
//

import UIKit

class AddNewToDoController: UIViewController {

    //MARK: - OUTLETS
    private lazy var nameOfTaskField = UITextField.createBasicTextField(textSize: 15, weight: .semibold, borderStyle: .roundedRect, returnKey: .next, tag: 0)
    private lazy var descriptionField = UITextField.createBasicTextField(textSize: 15, weight: .semibold, borderStyle: .roundedRect, returnKey: .done, tag: 1)
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
        view.addSubview(nameOfTaskField)
        view.addSubview(descriptionField)
        view.addSubview(dateField)
        view.addSubview(addNewToDoButton)
    }
    //MARK: - Setup Layout
    private func setupLayout() {
        nameOfTaskField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalTo(30)
        }
        
        descriptionField.snp.makeConstraints { make in
            make.top.equalTo(nameOfTaskField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalTo(30)
        }
        
        dateField.snp.makeConstraints { make in
            make.top.equalTo(descriptionField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(40)
        }
        
        addNewToDoButton.snp.makeConstraints { make in
            make.top.equalTo(dateField.snp.bottom).offset(30)
            make.leading.trailing.equalTo(50)
            make.height.equalTo(50)
            
        }
        
        addNewToDoButton.layer.cornerRadius = 10
        
    }
    //MARK: - Button Action
    @objc func addNewToDo() {
        
    }

 

}
