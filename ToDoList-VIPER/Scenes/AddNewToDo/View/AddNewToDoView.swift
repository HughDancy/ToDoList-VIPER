//
//  AddNewToDoView.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 20.03.2024.
//

import UIKit

final class AddNewToDoView: UIView {
    
    //MARK: - OUTLETS
    lazy var boxView: UIView = {
       let view = UIView(frame: CGRect(x: 20, y: 20, width: 50, height: 50))
        view.backgroundColor = .systemPink
        return view
    }()
    lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemRed
        button.tintColor = .systemBackground
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var titleOfScreen: UILabel = {
        let label = UILabel()
        label.text = "Добавить задачу"
        label.font = UIFont.systemFont(ofSize: 35, weight: .bold)
//        label.textColor = .systemCyan
        label.textColor = .systemPink
        return label
    }()
    
    lazy var nameOfTaskField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.backgroundColor = .systemGray6
        textField.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        textField.placeholder = "Наименование задачи"
        textField.layer.cornerRadius = 10
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
        textField.returnKeyType = .done
        textField.delegate = self
        textField.layer.shadowOffset = CGSize(width: 0, height: 2)
        textField.layer.shadowRadius = 3
        textField.layer.shadowColor = UIColor.black.cgColor
        textField.layer.shadowOpacity = 0.3
        return textField
    }()
    
    lazy var descriptionField: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .systemGray6
        textView.layer.shadowColor = UIColor.black.cgColor
        textView.layer.shadowOffset = CGSize(width:0,height: 2.0)
        textView.layer.shadowRadius = 3.0
        textView.layer.shadowOpacity = 0.3
        textView.layer.masksToBounds = false
        textView.layer.cornerRadius = 10
        
        return textView
    }()
    
    private lazy var dateStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Дата"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .systemCyan
        return label
    }()
    
     lazy var dateField: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .compact
        picker.locale = .current
        picker.layer.shadowOffset = CGSize(width: 0, height: 2)
        picker.layer.shadowRadius = 5
        picker.layer.shadowColor = UIColor.black.cgColor
        picker.layer.shadowOpacity = 0.3
        return picker
    }()
    
    private lazy var colorLabel: UILabel = {
        let label = UILabel()
        label.text = "Категория:"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .systemCyan
        return label
    }()
    
    lazy var cathegoryList: UITableView = {
        let tableVIew = UITableView(frame: .zero, style: .plain)
        tableVIew.backgroundColor = .systemBackground
        tableVIew.isScrollEnabled = false
        tableVIew.showsVerticalScrollIndicator = false
        tableVIew.separatorStyle = .none
        tableVIew.register(CathegoryCell.self, forCellReuseIdentifier: CathegoryCell.reuseIdentifier)
        return tableVIew
    }()
    
    lazy var addNewToDoButton = UIButton.createToDoButton(title: "Add new ToDo", backColor: UIColor(named: "customOrange") ?? .systemOrange, tintColor: .systemBackground)
    
    //MARK: - Init
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupHierarchy()
        setupLayout()
        setupTextView()
        self.backgroundColor = .systemBackground
    }
    
    //MARK: - Setup Hierarchy
    private func setupHierarchy() {
        self.addSubview(boxView)
        self.addSubview(closeButton)
        self.addSubview(titleOfScreen)
        self.addSubview(nameOfTaskField)
        self.addSubview(descriptionField)
        self.addSubview(dateStack)
        dateStack.addArrangedSubview(dateLabel)
        dateStack.addArrangedSubview(dateField)
        self.addSubview(colorLabel)
        self.addSubview(cathegoryList)
        self.addSubview(addNewToDoButton)
    }
    
    //MARK: - Setup Layout
    private func setupLayout() {
//        boxView.snp.makeConstraints { make in
//            <#code#>
//        }
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalToSuperview().offset(15)
            make.height.width.equalTo(30)
        }
        
        titleOfScreen.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset((UIScreen.main.bounds.height / 5) - (UIScreen.main.bounds.width / 5))
            make.top.equalTo(closeButton.snp.bottom).offset(10)
//            make.centerX.equalToSuperview()
        }
        
        nameOfTaskField.snp.makeConstraints { make in
            make.top.equalTo(titleOfScreen.snp.bottom).offset((UIScreen.main.bounds.height / 13) - (UIScreen.main.bounds.width / 13))
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalTo(50)
        }
        
        descriptionField.snp.makeConstraints { make in
            make.top.equalTo(nameOfTaskField.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalTo(UIScreen.main.bounds.height / 7)
        }
        
        dateStack.snp.makeConstraints { make in
            make.top.equalTo(descriptionField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(50)
            make.height.equalTo(50)
        }
        
        colorLabel.snp.makeConstraints { make in
            make.top.equalTo(dateStack.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(50)
        }
        
        cathegoryList.snp.makeConstraints { make in
            make.top.equalTo(colorLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(35)
            make.bottom.equalTo(addNewToDoButton.snp.top).inset(5)
        }
        
        addNewToDoButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(40)
//            make.leading.trailing.equalToSuperview().inset(40)
            make.centerX.equalToSuperview().inset(40)
            make.height.width.equalTo(50)
        }
        
        addNewToDoButton.layer.cornerRadius = 20
        addNewToDoButton.clipsToBounds = true
    }
    
    //MARK: - Setup TextView
    private func setupTextView() {
        descriptionField.text = "Описание задачи"
        descriptionField.textColor = .lightGray
        descriptionField.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        
        descriptionField.delegate = self
        descriptionField.returnKeyType = .done
    }
}

//MARK: - Extenstion UITexField
extension AddNewToDoView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameOfTaskField.resignFirstResponder()
        return true
    }
}

//MARK: - Extension UITextView
extension AddNewToDoView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if descriptionField.text == "Описание задачи"  {
            descriptionField.text = ""
            textView.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
            textView.textColor = UIColor.label
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            descriptionField.resignFirstResponder()
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if descriptionField.text == "" {
            descriptionField.text = "Описание задачи"
            descriptionField.textColor = .lightGray
            descriptionField.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        }
    }
}
