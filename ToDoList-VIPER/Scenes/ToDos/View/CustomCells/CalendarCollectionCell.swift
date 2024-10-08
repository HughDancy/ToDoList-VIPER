//
//  CalendarCollectionCell.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 26.03.2024.
//

import UIKit

final class CalendarCollectionCell: UICollectionViewCell {
    static let reuseIdentifier = "CalndarCollectionCell"
    var dateString = ""

    // MARK: - Outlets
    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .systemGray6
        return view
    }()

    private lazy var dayOfWeekLabel = UILabel.createSimpleLabel(text: "", size: 15.0, width: .semibold, color: .label, aligment: .center, numberLines: 0)
    private lazy var dayNumberLabel = UILabel.createSimpleLabel(text: "", size: 15.0, width: .semibold, color: .label, aligment: .center, numberLines: 0)

    private lazy var circlesStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 5
        stack.contentMode = .scaleAspectFit
        stack.distribution = .fillEqually
        return stack
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        contentView.backgroundColor = UIColor(named: "tasksBackground")
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func commonInit() {
        setupHierarchy()
        setupLayout()
    }

    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                containerView.backgroundColor = .systemIndigo
                dayNumberLabel.textColor = .white
                self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            } else {
                self.transform = CGAffineTransform.identity
                if dayOfWeekLabel.text == "Сб" || dayOfWeekLabel.text == "Вс" {
                    containerView.backgroundColor = UIColor(named: "hollydayColor")
                    dayNumberLabel.textColor = .label
                } else {
                    containerView.backgroundColor = .systemGray6
                    dayNumberLabel.textColor = .label
                }
            }
        }
    }

    // MARK: - Setup Hierarchy
    private func setupHierarchy() {
        contentView.addSubview(containerView)
        containerView.addSubview(dayOfWeekLabel)
        containerView.addSubview(dayNumberLabel)
        contentView.addSubview(circlesStack)
    }

    // MARK: - SetupLayout
    private func setupLayout() {
        containerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(5)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom).inset(10)
        }

        dayOfWeekLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(10)
            make.centerX.equalTo(containerView.snp.centerX)
        }

        dayNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(dayOfWeekLabel.snp.bottom).offset(3)
            make.centerX.equalTo(containerView.snp.centerX)
        }

        circlesStack.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom).offset(5)
            make.centerX.equalTo(containerView.snp.centerX)
        }
    }

    func setupCell(_ dateItem: DateItem) {
        dayOfWeekLabel.text = dateItem.dayOfWeek
        dayNumberLabel.text = dateItem.numberOfDay
        self.dateString = dateItem.dateString
        if self.dayOfWeekLabel.text == "Сб" || self.dayOfWeekLabel.text == "Вс" {
            self.containerView.backgroundColor = UIColor(named: "hollydayColor")
        } else {
            self.containerView.backgroundColor = .systemGray6
        }
        getMarkingCell(with: dateItem.isWorkTask ?? false, color: .systemOrange)
        getMarkingCell(with: dateItem.isPersonalTask ?? false, color: UIColor(named: "taskGreen") ?? .systemGreen)
        getMarkingCell(with: dateItem.isOtherTask ?? false, color: .systemPurple)
    }

    private func getMarkingCell(with bool: Bool, color: UIColor) {
        if bool {
            let view = UIView()
            view.backgroundColor = color
            view.layer.cornerRadius = 5
            view.clipsToBounds = true
            self.circlesStack.addArrangedSubview(view)
            view.snp.makeConstraints { make in
                make.height.width.equalTo(10)
            }
        }
    }

    override func prepareForReuse() {
        dayOfWeekLabel.text = nil
        dayNumberLabel.text = nil
        circlesStack.removeAllArrangedSubViews()
        self.isSelected = false
    }
}
