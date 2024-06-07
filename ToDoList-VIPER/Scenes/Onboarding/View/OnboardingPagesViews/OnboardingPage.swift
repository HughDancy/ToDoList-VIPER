//
//  WelcomeController.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 17.01.2024.
//

import UIKit

class OnboardingPage: UIViewController {
    
    var state: OnboardingStates?
    
    //MARK: - Outlets
    private lazy var picture: UIImageView = {
        let picture = UIImageView()
        picture.contentMode = .scaleAspectFill
        picture.backgroundColor = .clear
        return picture
    }()
    
    private lazy var descriptionTitle: UILabel = {
        let label = UILabel.createSimpleLabel(text: "", 
                                              size: OnboardingSizes.textSize.getTextSize(),
                                              width: .bold,
                                              color: .label)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var nextScreenButton: BaseButton = {
        let button = BaseButton(text: "", color: .systemCyan)
        button.setupShadows(with: .label)
        button.isHidden = true
        return button
    }()
    
    //MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UserDefaults.standard.setValue(state?.rawValue, forKey: "onboardingState")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupHierarchy()
        setupLayout()
    }
    
    //MARK: - Setup Outlets
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
            make.bottom.equalToSuperview().inset(OnboardingSizes.labelBottomOffset.getOffsetSize())
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(10)
        }

        nextScreenButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionTitle.snp.bottom).offset(10)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.height.equalTo(OnboardingSizes.buttonSize.getButtonSize())
        }
    }
    
    func setupElements(with data: OnboardingItems) {
        self.descriptionTitle.text = data.title
        self.picture.image = UIImage(named: data.imageName)
        nextScreenButton.setTitle(data.buttonText, for: .normal)
    }
}

enum OnboardingSizes: CGFloat {
    case textSize = 28
    case labelBottomOffset = 110
    case buttonSize = 45
    
    func getTextSize() -> CGFloat {
        UIScreen.main.bounds.height > 700 ? rawValue : rawValue - 8.0
    }
    
    func getOffsetSize() -> CGFloat {
        UIScreen.main.bounds.height > 700 ? rawValue : rawValue - 55.0
    }
    
    func getButtonSize() -> CGFloat {
        UIScreen.main.bounds.height > 700 ? rawValue : rawValue - 10.0
    }
}
