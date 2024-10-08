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
    var parrentView: ToDoListViewProtocol?

    // MARK: - Elements
    private lazy var taskLabel =  UILabel.createToDoLabel(fontSize: 20, weight: .bold, title: "Задача")
    private lazy var descriptionLabel = UILabel.createToDoLabel(fontSize: 20, weight: .bold, title: "Описание")
    private lazy var dateLabel = UILabel.createToDoLabel(fontSize: 20, weight: .bold, title: "Дата")
    private lazy var taskNameField: UITextField = {
        let taskName = UITextField.createToDoTextField()
        taskName.tag = 0
        taskName.delegate = self
        taskName.returnKeyType = .done
        taskName.becomeFirstResponder()
        return taskName
    }()
    private lazy var descriptionTaskField: UITextField = {
      let textField  = UITextField.createToDoTextField()
        textField.tag = 1
        textField.returnKeyType = .done
        textField.delegate = self
        return textField
    }()
    private lazy var datePicker = UIDatePicker.createToDoPicker()
    private lazy var addButton = BaseButton(text: "Добавить", color: .systemCyan)

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupHierarchy()
        setupLayout()
        addButton.addTarget(self, action: #selector(addNewTask), for: .touchDown)
    }

    deinit {
        print("AddToDoController is ☠️")
    }

    // MARK: - Setup Elements
    private func setupHierarchy() {
        view.addSubview(taskLabel)
        view.addSubview(taskNameField)
        view.addSubview(descriptionLabel)
        view.addSubview(descriptionTaskField)
        view.addSubview(dateLabel)
        view.addSubview(datePicker)
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

        datePicker.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(5)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(15)
            make.height.equalTo(view.frame.height / 2)
        }

        addButton.snp.makeConstraints { make in
            make.top.equalTo(datePicker.snp.bottom).offset(25)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(35)
        }
    }

    @objc func addNewTask() {
        if taskNameField.text?.isEmpty != true && descriptionTaskField.text?.isEmpty != true {
            presenter?.addToDo(title: taskNameField.text ?? "Default",
                               content: descriptionTaskField.text ?? "Default",
                               date: datePicker.date,
                               done: false)
            parrentView?.presenter?.viewWillAppear()
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

// MARK: - TextField Delegte
extension AddToDoController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1

        if let nextResponder = self.view.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
