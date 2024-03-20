//
//  AddNewToDoController.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 15.03.2024.
//

import UIKit

class AddNewToDoController: UIViewController, AddNewToDoViewProtocol {
    private var color: ColorsItemResult?
    var presenter: AddNewToDoPresenterProtocol?
    
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
        textField.returnKeyType = .done
        textField.delegate = self
        textField.layer.shadowOffset = CGSize(width: 0, height: 2)
        textField.layer.shadowRadius = 5
        textField.layer.shadowColor = UIColor.black.cgColor
        textField.layer.shadowOpacity = 0.3
        return textField
    }()
    
    private lazy var descriptionField: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .systemGray5
//        textView.layer.cornerRadius = 10
//        textView.layer.shadowOffset = CGSize(width: 0, height: 10)
//        textView.layer.shadowRadius = 30
//        textView.layer.shadowColor = UIColor.black.cgColor
//        textView.layer.shadowPath = UIBezierPath(rect: textView.bounds).cgPath
//        textView.layer.shadowOpacity = 1.0
        textView.layer.shadowColor = UIColor.black.cgColor
        textView.layer.shadowOffset = CGSize(width:0,height: 2.0)
        textView.layer.shadowRadius = 10.0
        textView.layer.shadowOpacity = 0.4
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
    
    private lazy var dateField: UIDatePicker = {
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
    
    private lazy var cathegoryList: UITableView = {
        let tableVIew = UITableView(frame: .zero, style: .plain)
        tableVIew.backgroundColor = .systemBackground
        tableVIew.delegate = self
        tableVIew.dataSource = self
        tableVIew.isScrollEnabled = false
        tableVIew.showsVerticalScrollIndicator = false
        tableVIew.separatorStyle = .none
        tableVIew.register(CathegoryCell.self, forCellReuseIdentifier: CathegoryCell.reuseIdentifier)
        return tableVIew
    }()
    
    private lazy var addNewToDoButton = UIButton.createToDoButton(title: "Add new ToDo", backColor: .systemCyan, tintColor: .systemBackground)
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupHierarchy()
        setupLayout()
        setupTextView()
        addNewToDoButton.addTarget(self, action: #selector(addNewToDo), for: .touchDown)
    }
    
    //MARK: - Setup Hierarchy
    private func setupHierarchy() {
        view.addSubview(titleOfScreen)
        view.addSubview(nameOfTaskField)
        view.addSubview(descriptionField)
        view.addSubview(dateStack)
        dateStack.addArrangedSubview(dateLabel)
        dateStack.addArrangedSubview(dateField)
        view.addSubview(colorLabel)
        view.addSubview(cathegoryList)
        view.addSubview(addNewToDoButton)
    }
    //MARK: - Setup Layout
    private func setupLayout() {
        titleOfScreen.snp.makeConstraints { make in
            make.top.equalToSuperview().offset((UIScreen.main.bounds.height / 5) - (UIScreen.main.bounds.width / 5))
            make.centerX.equalToSuperview()
        }
        
        nameOfTaskField.snp.makeConstraints { make in
            make.top.equalTo(titleOfScreen.snp.bottom).offset((UIScreen.main.bounds.height / 9) - (UIScreen.main.bounds.width / 9))
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalTo(60)
        }
        
        descriptionField.snp.makeConstraints { make in
            make.top.equalTo(nameOfTaskField.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalTo(UIScreen.main.bounds.height / 5)
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
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalTo(50)
        }
        
        addNewToDoButton.layer.cornerRadius = 10
    }
    
    //MARK: - Setup TextView
    private func setupTextView() {
        descriptionField.text = "Описание задачи"
        descriptionField.textColor = .lightGray
        descriptionField.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        
        descriptionField.delegate = self
        descriptionField.returnKeyType = .done
    }
    
    //MARK: - Buttons Action
    @objc func addNewToDo() {
        presenter?.addNewToDo(with: nameOfTaskField.text ?? "Do it", description: descriptionField.text, date: dateField.date, mark: color?.rawValue ?? ColorsItemResult.systemMint.rawValue)
    }
    
    @objc func removeTextInTextView() {
        self.descriptionField.text = ""
    }
}

//MARK: - UITextView Delegate
extension AddNewToDoController: UITextViewDelegate {
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

//MARK: - TextField Delegate
extension AddNewToDoController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameOfTaskField.resignFirstResponder()
        return true
    }
}

//MARK: - CollectionView Delegate
extension AddNewToDoController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ColorsItem.colorsStack.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CathegoryCell.reuseIdentifier, for: indexPath) as? CathegoryCell
        let cathegoryName = ["Работа", "Личное", "Иное"]
        cell?.setupCell(with: ColorsItem.colorsStack[indexPath.row], title: cathegoryName[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch ColorsItem.colorsStack[indexPath.row] {
                case .systemOrange:
                    self.color = ColorsItemResult.systemOrange
                case .systemYellow:
                    self.color = ColorsItemResult.systemYellow
                case .systemMint:
                    self.color = ColorsItemResult.systemMint
                default:
                    self.color = ColorsItemResult.systemOrange
                }
    }
}
