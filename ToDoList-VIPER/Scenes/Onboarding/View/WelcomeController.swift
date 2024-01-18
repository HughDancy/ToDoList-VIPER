//
//  WelcomeController.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 17.01.2024.
//

import UIKit

class WelcomeController: UIViewController, WelcomeViewProtocol {
    var presenter: OnboardingPresenterProtocol?
    
    //MARK: - Outlets
    private lazy var backgroundImage: UIImageView = {
        let picture = UIImageView()
        picture.image = UIImage(named: "loadingBackground")
        picture.contentMode = .scaleAspectFill
        return picture
    }()
    
    private lazy var botttomView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 45
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Добро пожаловать в ToDo List!"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private lazy var nextScreenButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Далее", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemCyan
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(goToLoginScreen), for: .touchDown)
        return button
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
        
    }
    
    //MARK: - Setup Outlets
    private func setupHierarchy() {
        view.addSubview(backgroundImage)
        view.sendSubviewToBack(backgroundImage)
        view.addSubview(botttomView)
        view.addSubview(welcomeLabel)
        view.addSubview(nextScreenButton)
    }
    
    private func setupLayout() {
        backgroundImage.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view)
        }
        
        botttomView.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom).offset(40)
            make.leading.trailing.equalTo(view)
            make.height.equalTo(200)
        }
        
        welcomeLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(view)
        }
        
        nextScreenButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(40)
            make.height.equalTo(45)
        }
    }
    
    //MARK: - Button function
    @objc func goToLoginScreen() {
        presenter?.goToLoginScreen()
    }
    
}
