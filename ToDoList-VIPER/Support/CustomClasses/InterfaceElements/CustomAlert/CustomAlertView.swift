//
//  CustomAlertView.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 25.04.2024.
//

import UIKit

final class CustomAlertView: UIView {
    weak var delegate: AlertControllerDelegate?
    private var closure: (Bool) -> Void
    private var type: CustomAlertType

    // MARK: - Outlets
    private lazy var parrentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.spacing = AlertSizes.innerSpacing.rawValue * 2
        return stack
    }()

    private lazy var titleStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalCentering
        stack.alignment = .fill
        stack.spacing = AlertSizes.innerSpacing.rawValue
        return stack
    }()

    private lazy var iconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        return label
    }()

    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }()

    private lazy var firstButton: BaseButton =  {
        let button = BaseButton(text: "", color: .systemCyan)
        button.setupShadows(with: .black)
        button.addTarget(self, action: #selector(firstButtonTapped), for: .touchDown)
        return button
    }()

    private lazy var secondButton: BaseButton = {
        let button = BaseButton(text: "", color: .systemOrange)
        button.setupShadows(with: .black)
        button.addTarget(self, action: #selector(secondButtonTapped), for: .touchDown)
        return button
    }()

    // MARK: - Init
    init(type: CustomAlertType, title: String, message: String, image: UIImage, colorOne: UIColor, colorTwo: UIColor?, buttonTitleOne: String, buttonTitleTwo: String?, closure: @escaping (Bool) -> Void) {
        self.closure = closure
        self.type = type
        super.init(frame: .zero)
        backgroundColor = UIColor(named: "tasksBackground")
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = title
        messageLabel.text = message
        iconImage.image = image
        setupOkButton(with: buttonTitleOne, color: colorOne)
        setupNoButton(with: buttonTitleTwo, color: colorTwo)
        layer.cornerRadius = 10
        setupAlertView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup stackViews and his layout
    private func setupAlertView() {
        setupElements()
        setupLayout()
    }

    private func setupElements() {
        let sepparatorLine = UIView()
        sepparatorLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        sepparatorLine.backgroundColor = .label

        parrentStack.addArrangedSubview(iconImage)
        titleStack.addArrangedSubview(titleLabel)
        titleStack.addArrangedSubview(sepparatorLine)
        parrentStack.addArrangedSubview(titleStack)
        parrentStack.addArrangedSubview(messageLabel)

        switch type {
        case .oneButton:
            firstButton.widthAnchor.constraint(equalToConstant: AlertSizes.buttonWidth.rawValue).isActive = true
            parrentStack.addArrangedSubview(firstButton)
            self.addSubview(parrentStack)
        case .twoButtons:
            firstButton.widthAnchor.constraint(equalToConstant: AlertSizes.buttonWidth.rawValue).isActive = true
            secondButton.widthAnchor.constraint(equalToConstant: AlertSizes.buttonWidth.rawValue).isActive = true
            let buttonsStack = UIStackView()
            buttonsStack.axis = .horizontal
            buttonsStack.distribution = .equalCentering
            buttonsStack.alignment = .fill
            buttonsStack.spacing = AlertSizes.outerSpacing.rawValue
            buttonsStack.addArrangedSubview(firstButton)
            buttonsStack.addArrangedSubview(secondButton)
            parrentStack.addArrangedSubview(buttonsStack)
            self.addSubview(parrentStack)
        }
    }

    private func setupLayout() {
        parrentStack.snp.makeConstraints { make in
            make.top.bottom.equalTo(self.safeAreaLayoutGuide).inset(AlertSizes.buttonTopAnchor.rawValue)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(AlertSizes.outerSpacing.rawValue)
        }
    }

    // MARK: - Button's setup
    private func setupOkButton(with title: String, color: UIColor) {
        firstButton.setTitle(title, for: .normal)
        firstButton.backgroundColor = color
        firstButton.tintColor = .systemBackground
    }

    private func setupNoButton(with title: String?, color: UIColor?) {
        secondButton.setTitle(title, for: .normal)
        secondButton.backgroundColor = color
        secondButton.tintColor = .systemBackground
    }

    // MARK: - Button's methods
    @objc func firstButtonTapped() {
        delegate?.dismissMe()
        closure(false)
    }

    @objc func secondButtonTapped() {
        delegate?.dismissMe()
        closure(true)
    }
}

    // MARK: - Support Enum's
enum CustomAlertType {
    case oneButton
    case twoButtons
}

private enum AlertSizes: CGFloat {
    case innerSpacing = 8
    case outerSpacing = 40
    case buttonWidth = 100
    case buttonTopAnchor = 16
}
