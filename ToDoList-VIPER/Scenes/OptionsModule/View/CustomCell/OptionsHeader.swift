//
//  OptionsHeader.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 02.12.2023.
//

import UIKit

class OptionsHeader: UITableViewHeaderFooterView {
    
    static let reuseIdentifier = "OptionsHeader"
    
    //MARK: - Elements
    private lazy var avatar: UIImageView = {
        let avatar = UIImageView()
        avatar.layer.cornerRadius = 50 / 2
        avatar.clipsToBounds = true
        avatar.image = UIImage(named: "testAva")
        
        return avatar
    }()
    
    private lazy var nicknameLabel: UILabel = {
       let label = UILabel()
        label.text = "Nickname user"
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textColor = .systemTeal
        return label
    }()
    
    private lazy var editButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "pencil.circle"), for: .normal)
        button.tintColor = .systemBlue
        
        return button
    }()
    
    //MARK: - Init
    override init(reuseIdentifier: String?) {
            super.init(reuseIdentifier: reuseIdentifier)
            setupHierarchy()
            setupLayout()
            
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    //MARK: - Setup Elements
    
    private func setupHierarchy() {
        contentView.addSubview(avatar)
        contentView.addSubview(nicknameLabel)
        contentView.addSubview(editButton)
    }
    
    private func setupLayout() {
        avatar.snp.makeConstraints { make in
            make.centerY.centerX.equalTo(contentView.safeAreaLayoutGuide)
            make.height.width.equalTo(50)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(avatar.snp.bottom).offset(10)
            make.centerY.equalTo(contentView.safeAreaLayoutGuide.snp.centerY)
        }
        
        editButton.snp.makeConstraints { make in
            make.leading.equalTo(nicknameLabel.snp.trailing).offset(5)
        }
        
        //MARK: - Refactor to setup elements with entity
        func setupElements() {
            
        }
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
