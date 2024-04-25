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
    
    //MARK: - Outlets
    lazy var iconImage: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        return label
    }()
    
    lazy var okButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemCyan
        button.tintColor = .systemBackground
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowOffset = CGSize(width: 1, height: 1)
        button.layer.shadowRadius = 1
        button.layer.cornerRadius = 10
        return button
    }()
    
    //MARK: - Init
    init(title: String, message: String, image: UIImage, closure: @escaping (Bool) -> Void) {
        self.closure = closure
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = title
        messageLabel.text = message
        iconImage.image = image
        layer.cornerRadius = 10
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Other methods
    
    private func setupLayout() {
        let innerSpacing: CGFloat = 8
        let outerSpacing: CGFloat = 40
        
        let parrentStackView = UIStackView()
        parrentStackView.axis = .vertical
        parrentStackView.distribution = .equalSpacing
        parrentStackView.alignment = .top
        parrentStackView.spacing = innerSpacing * 2
        
        let titleStakView = UIStackView()
        titleStakView.axis = .vertical
        titleStakView.distribution = .equalCentering
        titleStakView.alignment = .fill
        titleStakView.spacing = innerSpacing
        
        let sepparatorLine = UIView()
        sepparatorLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        sepparatorLine.backgroundColor = .label
        
        titleStakView.addArrangedSubview(titleLabel)
        titleStakView.addArrangedSubview(sepparatorLine)
        parrentStackView.addArrangedSubview(titleStakView)
        parrentStackView.addArrangedSubview(messageLabel)
        
        okButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        okButton.setTitle("Ok", for: .normal)
        okButton.addTarget(self, action: #selector(okTapped), for: .touchDown)
        parrentStackView.addArrangedSubview(okButton)
        self.addSubview(parrentStackView)
        
        parrentStackView.snp.makeConstraints { make in
            make.top.bottom.equalTo(self.safeAreaLayoutGuide).inset(16)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(outerSpacing)
        }
        
    }
    
    //MARK: - Button's methods
    @objc func okTapped() {
        delegate?.dismissMe()
        closure(true)
    }
}
