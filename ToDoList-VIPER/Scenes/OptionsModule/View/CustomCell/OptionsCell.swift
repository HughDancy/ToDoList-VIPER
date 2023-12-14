//
//  OptionsCell.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 02.12.2023.
//

import UIKit

class OptionsCell: UITableViewCell {
    
    static let reuseIdentifier = "OptionsCell"
    var index = -1
    weak var delegate: SwitchThemeProtocol?
    
    //MARK: - Elements
    private lazy var icon: UIImageView = {
        let icon = UIImageView()
        
        return icon
    }()
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        
        return label
    }()
    
    private lazy var  container: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
     private lazy var switcher: Switch =  {
        let switcher = Switch()
        switcher.offImage = UIImage(named: "nightSky")?.cgImage
        switcher.onImage = UIImage(named: "daySky")?.cgImage
        switcher.addTarget(self, action: #selector(changeTheme), for: .touchUpInside)
        return switcher
    }()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .systemBackground
        setupHierarchy()
        setupLayout()
        configureIsOnSwitcher()
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup Elements
    private func setupHierarchy() {
        contentView.addSubview(container)
        container.addSubview(icon)
        container.addSubview(title)
        container.addSubview(switcher)
    }
    
    private func setupLayout() {
        container.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }
        
        icon.snp.makeConstraints { make in
            make.top.equalTo(container).inset(10)
            make.leading.equalTo(container.snp.leading).offset(10)
            make.height.width.equalTo(40)
            make.bottom.equalTo(container.snp.bottom).inset(15)
        }
        
        title.snp.makeConstraints { make in
            make.top.equalTo(container.snp.top).offset(15)
            make.centerX.equalTo(container.snp.centerX)
            make.bottom.equalTo(container.snp.bottom).inset(15)
            make.leading.equalTo(icon.snp.trailing).offset(15)
        }
        
        switcher.snp.makeConstraints { make in
            make.top.equalTo(container.snp.top).offset(15)
            make.trailing.equalTo(container.safeAreaLayoutGuide.snp.trailing).inset(10)
            make.height.equalTo(35)
            make.width.equalTo(70)
        }
        
    }
    
    func setupElements(text: String, image: String, index: Int) {
        title.text = text
        icon.image = UIImage(named: image)
        setupSwitcher(index: index)
    }
    
    private func configureIsOnSwitcher() {
        if ToDoUserDefaults.shares.theme.rawValue == "dark" {
            switcher.isOn = true
        } else {
            switcher.isOn = false
        }
    }
    
    private func setupSwitcher(index: Int) {
        if index == 0 {
            switcher.isHidden = false
        } else {
            switcher.isHidden = true
        }
    }
    
    @objc func changeTheme() {
       delegate?.changeUserTheme(with: switcher.isOn)
    }
}
