//
//  WelcomeController.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 17.01.2024.
//

import UIKit

class OnboardingPageController: UIViewController {
    
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
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    lazy var photoAndLibraryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemCyan
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.setTitle("Разрешить доступ", for: .normal)
        return button
    }()
    
    lazy var nextScreenButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemCyan
        button.layer.cornerRadius = 13
        button.titleLabel?.adjustsFontSizeToFitWidth = true
//        button.clipsToBounds = true
        
        return button
    }()
    
    lazy var stack: UIStackView = {
       let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 3
        stack.setCustomSpacing(3.0, after: photoAndLibraryButton)
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
//        stack.addArrangedSubview(descriptionLabel)
        stack.addArrangedSubview(photoAndLibraryButton)
        stack.addArrangedSubview(photoAndLibraryButton)
        stack.addArrangedSubview(nextScreenButton)
//        stack.addArrangedSubview(picture)
//        view.addSubview(picture)
//        view.addSubview(welcomeLabel)
//        view.addSubview(descriptionLabel)
//        view.addSubview(photoAndLibraryButton)
//        view.addSubview(photoAndLibraryButton)
//        view.addSubview(nextScreenButton)
    }
    
    private func setupLayout() {
        stack.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        welcomeLabel.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        
        picture.snp.makeConstraints { make in
            make.height.equalTo(530)
        }
        
        
        nextScreenButton.snp.makeConstraints { make in
            make.height.equalTo(55)
        }
        
        photoAndLibraryButton.snp.makeConstraints { make in
            make.height.equalTo(55)
        }
//        picture.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
//            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(65)
//            make.height.equalTo(500)
//        }
//        
//        welcomeLabel.snp.makeConstraints { make in
//            make.top.equalTo(picture.snp.bottom).offset(30)
//            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
//            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(1)
////            make.height.equalTo(40)
//        }
//        
//        descriptionLabel.snp.makeConstraints { make in
//            make.top.equalTo(welcomeLabel.snp.bottom).offset(10)
//            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
//        }
//        
//        photoAndLibraryButton.snp.makeConstraints { make in
//            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(40)
//            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(80)
//            make.height.equalTo(40)
//        }
//        
//        nextScreenButton.snp.makeConstraints { make in
//            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(40)
//            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(30)
//            make.height.equalTo(40)
//        }
    }
    
    func setupElements(with data: OnboardingItems) {
        welcomeLabel.text = data.title
        descriptionLabel.text = data.description
        nextScreenButton.setTitle(data.buttonText, for: .normal)
        picture.image = UIImage(named: data.imageName)
        self.state = data.state
    }
}
