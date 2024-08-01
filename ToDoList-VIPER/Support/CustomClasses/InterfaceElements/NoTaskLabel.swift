//
//  NoTaskLabel.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 13.05.2024.
//

import UIKit

final class NoTaskLabel: UILabel {
    var status: ToDoListStatus

    // MARK: - Init
    init(status: ToDoListStatus?, size: CGFloat, weight: UIFont.Weight, color: UIColor) {
        self.status = status ?? .today
        super.init(frame: .zero)
        self.font = UIFont.systemFont(ofSize: size, weight: weight)
        self.textColor = color
        setupLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup Label
    private func setupLabel() {
        self.text = self.getLabelText(with: self.status)
        self.numberOfLines = 0
        self.lineBreakMode = .byWordWrapping
        self.textAlignment = .center
    }

    // MARK: - Setup Text of label
    private func getLabelText(with status: ToDoListStatus) -> String {
        switch status {
        case .today, .tommorow:
            return "Задачи отсутствуют"
        case .overdue:
            return "Просроченные задачи отсутствуют"
        case .done:
            return "Выполненные задачи отсутствуют"
        }
    }
}
