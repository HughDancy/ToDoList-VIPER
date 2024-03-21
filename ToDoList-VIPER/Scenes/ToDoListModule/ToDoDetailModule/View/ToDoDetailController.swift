//
//  ToDoDetailController.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 13.11.2023.
//

import UIKit
import SnapKit

class ToDoDetailController: UIViewController {
    
    var presenter: ToDoDetailPresenterProtocol?
    
    //MARK: - Outlets
    private lazy var titleLabel: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 45, weight: .bold)
//        textView.textColor = .systemBlue
        textView.isScrollEnabled = false
        textView.isUserInteractionEnabled = false
        return textView
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        label.textAlignment = .left
        label.text = "Дата: "
        return label
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .compact
        picker.locale = .current
        picker.isUserInteractionEnabled = false
        
        return picker
    }()
    
    private lazy var descripTionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        label.textAlignment = .left
        label.text = "Описание: "
        return label
    }()
    
    private lazy var contentTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        textView.isEditable = false
        textView.isScrollEnabled = false
        
        return textView
    }()
    
    private lazy var editButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(editToDo), for: .touchDown)
        
        return button
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(saveToDo), for: .touchDown)
        button.isHidden = true
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Delete", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(deleteToDo), for: .touchDown)
        
        return button
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        presenter?.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupHierarchy()
        setupLayout()
    }
    
    //MARK: - Setup Outlets
    private func setupHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(timeLabel)
        view.addSubview(datePicker)
        view.addSubview(descripTionLabel)
        view.addSubview(contentTextView)
        view.addSubview(editButton)
        view.addSubview(saveButton)
        view.addSubview(deleteButton)
    }
    
    private func setupLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(20)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
        }
        
        datePicker.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalTo(timeLabel.snp.trailing).offset(10)
        }
        
        descripTionLabel.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(13)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
        }
        
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(descripTionLabel.snp.bottom).offset(1)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        editButton.snp.makeConstraints { make in
            make.bottom.equalTo(deleteButton.snp.top).offset(-15)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
        
        saveButton.snp.makeConstraints { make in
            make.bottom.equalTo(deleteButton.snp.top).offset(-15)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(25)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
    }
    
    //MARK: - Button's Action's
    @objc func editToDo() {
        editButton.isHidden = true
        saveButton.isHidden = false
        titleLabel.isEditable = true
        titleLabel.becomeFirstResponder()
        contentTextView.isEditable = true
        datePicker.isUserInteractionEnabled = true
    }
    
    @objc func deleteToDo() {
        presenter?.deleteToDo()
    }
    
    @objc func saveToDo() {
        saveButton.isHidden = true
        editButton.isHidden = false
        titleLabel.isEditable = false
        contentTextView.isEditable = false
        datePicker.isUserInteractionEnabled = false
        presenter?.editToDo(title: titleLabel.text ?? "", content: contentTextView.text ?? "", date: datePicker.date)
        print(datePicker.date)
        
    }
}

    //MARK: - ToDoDetail Protocol Extension
extension ToDoDetailController: ToDoDetailViewProtocol {
    func showToDo(_ toDo: ToDoObject) {
        titleLabel.text = toDo.title
        switch toDo.color {
        case ColorsItemResult.systemOrange.rawValue:
            titleLabel.textColor = ColorsItem.colorsStack[0]
        case ColorsItemResult.systemGreen.rawValue:
            titleLabel.textColor = ColorsItem.colorsStack[1]
        case ColorsItemResult.systemPurple.rawValue:
            titleLabel.textColor = ColorsItem.colorsStack[2]
        default:
            titleLabel.textColor = .systemCyan
        }
        contentTextView.text = toDo.descriptionTitle
        datePicker.date = toDo.date ?? Date()
    }
}
