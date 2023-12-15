//
//  OptionsHeader.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 02.12.2023.
//

import UIKit

class OptionsHeader: UITableViewHeaderFooterView {
    
    static let reuseIdentifier = "OptionsHeader"
    weak var goUserOptionsDelegate: GoToUserOptionsProtocol?
    
    //MARK: - Elements
    private lazy var avatar: UIImageView = {
        let avatar = UIImageView()
        avatar.layer.cornerRadius = 100 / 2
        avatar.clipsToBounds = true
        avatar.image = UIImage(named: "testAva")
        avatar.contentMode = .scaleAspectFill
        
        return avatar
    }()
    
    private lazy var nicknameLabel: UILabel = {
       let label = UILabel()
        label.text = "Nickname user"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .systemTeal
        return label
    }()
    
    private lazy var editButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "pencil")
        button.setImage(UIImage(named: "pencil"), for: .normal)
        button.tintColor = .systemBlue
        button.addTarget(self, action: #selector(tapEdit), for: .touchDown)
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
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(15)
            make.centerX.equalTo(contentView.safeAreaLayoutGuide.snp.centerX)
            make.height.width.equalTo(100)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(avatar.snp.bottom).offset(10)
            make.centerX.equalTo(contentView.safeAreaLayoutGuide.snp.centerX)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom).inset(20)
        }
        
        editButton.snp.makeConstraints { make in
            make.top.equalTo(avatar.snp.bottom).offset(5)
            make.leading.equalTo(nicknameLabel.snp.trailing).offset(10)
            make.height.equalTo(25)
            make.width.equalTo(25)
        }
        
    }
    
    @objc func tapEdit() {
        goUserOptionsDelegate?.goToUserOptions()
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
    

