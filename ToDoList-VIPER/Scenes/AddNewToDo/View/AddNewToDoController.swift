//
//  AddNewToDoController.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 15.03.2024.
//

import UIKit

final class AddNewToDoController: UIViewController, AddNewToDoViewProtocol, UITableViewDelegate {
    private var color: ColorsItemResult?
    var presenter: AddNewToDoPresenterProtocol?
    
    private var addNewToDoView: AddNewToDoView? {
        guard isViewLoaded else { return nil }
        return view as? AddNewToDoView
    }
    
    //MARK: - OUTLETS
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemRed
        button.tintColor = .systemBackground
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(dismissToMain), for: .touchDown)
        return button
    }()
    
    private lazy var titleOfScreen: UILabel = {
        let label = UILabel()
        label.text = "Добавить задачу"
        label.font = UIFont.systemFont(ofSize: 35, weight: .bold)
//        label.textColor = .systemCyan
        label.textColor = .systemBackground
        return label
    }()
    
    private lazy var nameOfTaskField: UITextField = {
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
//        textField.layer.shadowOffset = CGSize(width: 0, height: 2)
//        textField.layer.shadowRadius = 3
//        textField.layer.shadowColor = UIColor.systemBackground.cgColor
//        textField.layer.shadowOpacity = 0.3
        return textField
    }()
    
    private lazy var descriptionField: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .systemGray6
//        textView.layer.shadowColor = UIColor.systemBackground.cgColor
//        textView.layer.shadowOffset = CGSize(width:0,height: 2.0)
//        textView.layer.shadowRadius = 3.0
//        textView.layer.shadowOpacity = 0.3
//        textView.layer.masksToBounds = false
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
        label.textColor = .systemBackground
        return label
    }()
    
     private lazy var dateField: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .compact
        picker.locale = Locale(identifier: "ru_RU")
//        picker.layer.shadowOffset = CGSize(width: 0, height: 2)
//        picker.layer.shadowRadius = 5
//        picker.layer.shadowColor = UIColor.systemBackground.cgColor
//        picker.layer.shadowOpacity = 0.3
        picker.backgroundColor = UIColor(named: "coralColor")
        return picker
    }()
    
    private lazy var colorLabel: UILabel = {
        let label = UILabel()
        label.text = "Категория:"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .systemBackground
        return label
    }()
    
    lazy var cathegoryList: UITableView = {
        let tableVIew = UITableView(frame: .zero, style: .plain)
        tableVIew.backgroundColor = UIColor(named: "coralColor")
        tableVIew.isScrollEnabled = false
        tableVIew.showsVerticalScrollIndicator = false
        tableVIew.separatorStyle = .none
        tableVIew.delegate = self
        tableVIew.dataSource = self
        tableVIew.register(CathegoryCell.self, forCellReuseIdentifier: CathegoryCell.reuseIdentifier)
        return tableVIew
    }()
    
    private lazy var addNewToDoButton: BaseButton = {
        let button = BaseButton(text: "Добавить задачу", color: UIColor(named: "customBlue") ?? .systemOrange)
        button.addTarget(self, action: #selector(addNewToDo), for: .touchDown)
        return button
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "coralColor")
        setupHierarchy()
        setupLaout()
        setupTextView()
    }
    
    //MARK: - Setup Hierarchy
    private func setupHierarchy() {
        view.addSubview(closeButton)
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
    private func setupLaout() {
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
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalTo(50)
        }
        
        addNewToDoButton.layer.cornerRadius = 20
        dateField.layer.cornerRadius = 10
    }
    
    //MARK: - Setup View Outelets
    private func setupTextView() {
        descriptionField.text = "Описание задачи"
        descriptionField.textColor = .lightGray
        descriptionField.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        
        descriptionField.delegate = self
        descriptionField.returnKeyType = .done
    }
    
    //MARK: - Buttons Action
    @objc func addNewToDo() {
        presenter?.addNewToDo(with: nameOfTaskField.text,
                              description: descriptionField.text,
                              date: dateField.date,
                              mark: color?.rawValue ?? ColorsItemResult.systemPurple.rawValue)
        self.makeNotification()
    }
    
    @objc func dismissToMain() {
        presenter?.goBackToMain()
    }
    
    //MARK: - Notification
    func makeNotification() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdateTables"), object: nil)
    }
}

//MARK: - TableViewDelegate Extension
extension AddNewToDoController: UITabBarDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ColorsItem.colorsStack.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CathegoryCell.reuseIdentifier, for: indexPath) as? CathegoryCell
        let cathegoryName = ["Работа", "Личное", "Иное"]
        cell?.backgroundColor = UIColor(named: "coralColor")
        cell?.setupCell(with: ColorsItem.colorsStack[indexPath.row], title: cathegoryName[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
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
