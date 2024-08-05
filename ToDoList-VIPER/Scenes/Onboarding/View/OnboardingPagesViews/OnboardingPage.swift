//
//  WelcomeController.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 17.01.2024.
//

import UIKit

final class OnboardingPage: UIViewController {
    var state: OnboardingStates?

    // MARK: - Outlets
    private lazy var picture: UIImageView = {
        let picture = UIImageView()
        picture.contentMode = .scaleAspectFill
        picture.backgroundColor = .clear
        return picture
    }()

    private lazy var descriptionTitle = UILabel.createSimpleLabel(text: "",
                                                                  size: OnboardingSizes.textSize.value,
                                                                  width: .bold,
                                                                  color: .label,
                                                                  aligment: .center,
                                                                  numberLines: 0)

    lazy var nextScreenButton: BaseButton = {
        let button = BaseButton(text: "", color: .systemCyan)
        button.setupShadows(with: .label)
        button.isHidden = true
        return button
    }()

    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UserDefaults.standard.setValue(state?.rawValue, forKey: UserDefaultsNames.onboardingState.name)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupOnboardingPage()
    }

    // MARK: - Setup PageView
    private func setupOnboardingPage() {
        view.backgroundColor = .systemBackground
        setupHierarchy()
        setupLayout()
    }

    // MARK: - Setup Outlets
    private func setupHierarchy() {
        view.addSubview(picture)
        view.sendSubviewToBack(picture)
        view.addSubview(descriptionTitle)
        view.addSubview(nextScreenButton)
    }

    private func setupLayout() {
        picture.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(view)
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }

        descriptionTitle.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(OnboardingSizes.labelBottomOffset.value)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(OnboardingSizes.defaultOffset.value)
        }

        nextScreenButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionTitle.snp.bottom).offset(OnboardingSizes.defaultOffset.value)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(OnboardingSizes.buttonLeadingTrailing.value)
            make.height.equalTo(OnboardingSizes.buttonSize.value)
        }
    }

    // MARK: - Setup Elements
    func setupElements(with data: OnboardingItems) {
        self.descriptionTitle.text = data.title
        self.picture.image = UIImage(named: data.imageName)
        nextScreenButton.setTitle(data.buttonText, for: .normal)
    }
}

// MARK: - Sizes and constraint enum
enum OnboardingSizes: CGFloat {
    case textSize = 28
    case labelBottomOffset = 110
    case buttonSize = 45
    case defaultOffset = 10
    case buttonLeadingTrailing = 40

    var value: CGFloat {
        switch self {
        case .textSize:
            UIScreen.main.bounds.height > 700 ? rawValue : rawValue - 8.0
        case .labelBottomOffset:
            UIScreen.main.bounds.height > 700 ? rawValue : rawValue - 55.0
        case .buttonSize:
            UIScreen.main.bounds.height > 700 ? rawValue : rawValue - 10.0
        case .defaultOffset:
            10
        case .buttonLeadingTrailing:
            UIScreen.main.bounds.height > 700 ? rawValue : 30
        }
    }
}
