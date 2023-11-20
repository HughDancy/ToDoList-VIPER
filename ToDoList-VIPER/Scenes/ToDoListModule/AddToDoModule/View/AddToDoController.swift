//
//  AddToDoController.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 15.11.2023.
//

import UIKit
import SnapKit

class AddToDoController: UIViewController, AddToDoViewProtocol {
    
    var presenter: AddToDoPresenterProtocol?
    
    //MARK: - Elements
    private lazy var taskLabel = UILabel.createToDoLabel(fontSize: 20, weight: .bold, title: "Задача")
    private lazy var descriptionLabel = UILabel.createToDoLabel(fontSize: 20, weight: .bold, title: "Описание")
    private lazy var dateLabel = UILabel.createToDoLabel(fontSize: 20, weight: .bold, title: "Дата")
    private lazy var taskNameField = UITextField.createToDoTextField()
    private lazy var descriptionTaskField = UITextField.createToDoTextField()
    private lazy var toDoCalendar = UICalendarView.createToDoCalendar()
    private lazy var addButton: UIButton =  {
        let button = UIButton.createToDoButton(title: "Добавить", backColor: .systemBlue, tintColor: .white)
        button.addTarget(self, action: #selector(addNewTask), for: .touchDown)
        return button
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupHierarchy()
        setupLayout()
    }
    
    //MARK: - Setup Elements
    private func setupHierarchy() {
        view.addSubview(taskLabel)
        view.addSubview(taskNameField)
        view.addSubview(descriptionLabel)
        view.addSubview(descriptionTaskField)
        view.addSubview(dateLabel)
        view.addSubview(toDoCalendar)
        view.addSubview(addButton)
    }
    
    private func setupLayout() {
        
        taskLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(25)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(15)
        }
        
        taskNameField.snp.makeConstraints { make in
            make.top.equalTo(taskLabel.snp.bottom).offset(5)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(15)
            make.height.equalTo(35)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(taskNameField.snp.bottom).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(15)
        }
        
        descriptionTaskField.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(5)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(15)
            make.height.equalTo(35)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionTaskField.snp.bottom).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(15)
        }
        
        toDoCalendar.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(5)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(15)
            make.height.equalTo(view.frame.height / 2)
        }
        
        addButton.snp.makeConstraints { make in
            make.top.equalTo(toDoCalendar.snp.bottom).offset(25)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(35)
        }
    }
    
    @objc func addNewTask() {
        if taskNameField.text?.isEmpty != true && descriptionTaskField.text?.isEmpty != true {
            let toDoItem = ToDoItem(title: taskNameField.text ?? "Default", content: descriptionTaskField.text ?? "Default", date: "25.11.2023")
            presenter?.addToDo(toDoItem)
        } else {
            let alertVc = UIAlertController(title: "Ошибка",
                                            message: "Вы не заполнили как минимум одно из обязательных полей для добавления задачи",
                                            preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Ok", style: .cancel)
            alertVc.addAction(alertAction)
            self.present(alertVc, animated: true)
        }
    }
}

