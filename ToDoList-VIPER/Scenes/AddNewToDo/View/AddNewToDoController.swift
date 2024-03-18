//
//  AddNewToDoController.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 15.03.2024.
//

import UIKit

class AddNewToDoController: UIViewController {
    private var color: ColorsItemResult?
    
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
        return textField
    }()
    
    private lazy var descriptionField: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .systemGray5
        textView.layer.cornerRadius = 10
        
        return textView
    }()
    
    private lazy var dateStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 10
        //        stackView.distribution = .fillProportionally
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
        return picker
    }()
    
    private lazy var colorLabel: UILabel = {
        let label = UILabel()
        label.text = "Метка:"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .systemCyan
        return label
    }()
    
    private lazy var colorsCollectionView: UICollectionView = {
        let layout = createLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ColorsCell.self, forCellWithReuseIdentifier: ColorsCell.reuseIdentidier)
        collectionView.backgroundColor = .systemBackground
        return collectionView
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
        view.addSubview(colorsCollectionView)
        view.addSubview(addNewToDoButton)
    }
    //MARK: - Setup Layout
    private func setupLayout() {
        titleOfScreen.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.centerX.equalToSuperview()
        }
        
        nameOfTaskField.snp.makeConstraints { make in
            make.top.equalTo(titleOfScreen.snp.bottom).offset(50)
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalTo(60)
        }
        
        descriptionField.snp.makeConstraints { make in
            make.top.equalTo(nameOfTaskField.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(40)
            //            make.height.equalTo(100)
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
        
        colorsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(colorLabel.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(50)
            make.height.equalTo(100)
        }
        
        addNewToDoButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(50)
            make.leading.trailing.equalToSuperview().inset(50)
            make.height.equalTo(50)
        }
        
        addNewToDoButton.layer.cornerRadius = 10
    }
    
    //MARK: - Layout for CollectionView
    private func createLayout() -> UICollectionViewLayout {
        let spacing: CGFloat = 3.0
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.2),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(0.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        section.interGroupSpacing = spacing
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
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
        print(color)
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
extension AddNewToDoController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorsCell.reuseIdentidier, for: indexPath) as? ColorsCell
        cell?.setupCell(with: ColorsItem.colorsStack[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch ColorsItem.colorsStack[indexPath.row] {
        case .systemRed:
            self.color = ColorsItemResult.systemRed
        case .systemBlue:
            self.color = ColorsItemResult.systemBlue
        case .systemOrange:
            self.color = ColorsItemResult.systemOrange
        case .systemYellow:
            self.color = ColorsItemResult.systemYellow
        case .systemMint:
            self.color = ColorsItemResult.systemMint
        default:
            self.color = ColorsItemResult.systemOrange
        }
//        collectionView.cellForItem(at: indexPath)?.alpha = 0.4
    }
}
