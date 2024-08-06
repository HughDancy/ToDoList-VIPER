//
//  SingleToDoController.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 02.04.2024.
//

import UIKit

class SingleToDoController: UIViewController {
    var color: UIColor?
    var iconName: String?

    // MARK: - Base Outelts
    lazy var descriptionText: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .systemGray6
        textView.layer.cornerRadius = 10
        textView.clipsToBounds = true
        textView.delegate = self
        textView.accessibilityLabel = "DescriptionTextView"
        return textView
    }()

    lazy var dateStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 10
        return stack
    }()

    lazy var dateLabel: UILabel = {
        let label = UILabel.createSimpleLabel(text: "Дата", size: 20, width: .semibold, color: .systemBackground, aligment: .left, numberLines: 0)
        return label
    }()

    lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .compact
        picker.locale = Locale(identifier: "ru_RU")
        picker.backgroundColor = UIColor(named: "coralColor")
        picker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        picker.accessibilityLabel = "DatePicker"
        return picker
    }()

    lazy var categoryLabel: UILabel = {
        let label = UILabel.createSimpleLabel(text: "Категория:", size: 20, width: .semibold, color: .systemBackground, aligment: .left, numberLines: 1)
        return label
    }()

    lazy var categoryTableView = CategoryTableView(frame: .zero, style: .plain, color: UIColor(named: "coralColor") ?? .systemBackground)

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "coralColor")
        setupHierarchy()
        setupLayout()
        setupOutlets()
        setupTextView()
    }

    // MARK: - Setup Hierarchy
    func setupHierarchy() { }

    // MARK: - Setup Layout
    func setupLayout() { }

    // MARK: - Setup Outlets
    func setupOutlets() { }

    // MARK: - Setup TextView
    func setupTextView() { }

    // MARK: - Setup color and iconName
    func setupColorAndIcon(color: UIColor, icon: String) {
        self.color = color
        self.iconName = icon
    }

    @objc func dateChanged(_ datePicker: UIDatePicker) {
        self.dismiss(animated: true)
    }

    // MARK: - Setup elements user interaction
    func setupUserInteracton(with bool: Bool) {
        descriptionText.isUserInteractionEnabled = bool
        datePicker.isUserInteractionEnabled = bool
        categoryTableView.isUserInteractionEnabled = bool
    }
}

extension SingleToDoController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if descriptionText.text == "Описание задачи" || descriptionText.text == "Описание задачи не установлено" && descriptionText.isFirstResponder {
            descriptionText.text = ""
            descriptionText.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
            descriptionText.textColor = UIColor.label
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
