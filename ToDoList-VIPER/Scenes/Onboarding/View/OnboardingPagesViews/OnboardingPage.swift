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
        picture.contentMode = .scaleAspectFit
        picture.backgroundColor = .clear
        return picture
    }()
    
    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        return label
    }()

    lazy var nextScreenButton: BaseButton = {
        let button = BaseButton(text: "", color: .systemCyan)
        button.setupShadows(with: .label)
        return button
    }()

    lazy var stack: UIStackView = {
       let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .center
        stack.distribution = .equalSpacing
        return stack
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
        view.addSubview(stack)
        stack.addArrangedSubview(picture)
        stack.addArrangedSubview(welcomeLabel)
        stack.addArrangedSubview(nextScreenButton)
    }
    
    private func setupLayout() {
        stack.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        welcomeLabel.snp.makeConstraints { make in
            make.height.equalTo(70)
        }
  
        nextScreenButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.leading.trailing.equalToSuperview().inset(40)
        }
    }
    
    func setupElements(with data: OnboardingItems) {
        welcomeLabel.text = data.title
        nextScreenButton.setTitle(data.buttonText, for: .normal)
        picture.image = UIImage(named: data.imageName)
        self.state = data.state
    }
}
