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
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
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
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        
        return button
    }()
    
    //MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UserDefaults.standard.setValue(state?.rawValue, forKey: "onboardingState")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupHierarchy()
        setupLayout()
    }
    
    //MARK: - Setup Outlets
    private func setupHierarchy() {
        view.addSubview(picture)
        view.addSubview(welcomeLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(photoAndLibraryButton)
        view.addSubview(photoAndLibraryButton)
        view.addSubview(nextScreenButton)
    }
    
    private func setupLayout() {
        
        picture.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(300)
        }
        
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalTo(picture.snp.bottom).offset(30)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
//            make.height.equalTo(40)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        photoAndLibraryButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(80)
            make.height.equalTo(40)
        }
        
        nextScreenButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(30)
            make.height.equalTo(40)
        }
    }
    
    func setupElements(with data: OnboardingItems) {
        welcomeLabel.text = data.title
        descriptionLabel.text = data.description
        nextScreenButton.setTitle(data.buttonText, for: .normal)
        picture.image = UIImage(named: data.imageName)
        self.state = data.state
    }
}
