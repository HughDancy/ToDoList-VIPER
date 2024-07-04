//
//  OptionsCell.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 03.07.2024.
//

import UIKit

class OptionsCell: UITableViewCell {
    
    static let reuseIdentifier = "OptionsCell"
    weak var delegate: OptionCellDelegate?
    private var index: Int = -1
    
    //MARK: - Outlets
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var optionTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .label
        return label
    }()
    
    private lazy var switcher: CustomSwitcher = {
        let customSwitcher = CustomSwitcher()
        customSwitcher.offImage = UIImage(named: "nightSky")?.cgImage
        customSwitcher.onImage = UIImage(named: "daySky")?.cgImage
        customSwitcher.addTarget(self, action: #selector(changeTheme), for: .touchUpInside)
        return customSwitcher
    }()
    
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        self.contentView.backgroundColor = .systemBackground
        setupHierarchy()
        setupLayout()
        self.selectionStyle = .none
    }
    
    override func prepareForReuse() {
        self.optionTitle.text = nil
    }
    
    //MARK: - Setup Hierarchy
    private func setupHierarchy() {
        contentView.addSubview(containerView)
        containerView.addSubview(optionTitle)
        containerView.addSubview(switcher)
        
    }
    
    //MARK: - Setup Layout
    private func setupLayout() {
        containerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(5)
            make.leading.trailing.equalToSuperview().inset(15)
            make.height.equalTo(70)
        }
        
        optionTitle.snp.makeConstraints { make in
            make.centerX.equalTo(containerView.snp.centerX)
            make.top.equalTo(containerView.snp.top).offset(27)
            make.leading.equalTo(containerView.snp.leading).offset(20)
        }
        
        switcher.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(15)
            make.trailing.equalTo(containerView.safeAreaLayoutGuide.snp.trailing).inset(10)
            make.height.equalTo(35)
            make.width.equalTo(70)
        }
    }
    
    //MARK: - Setup Cell
    func setupCell(title: String, index: Int) {
        self.optionTitle.text = title
        self.index = index
        if self.index == 0 {
            switcher.isHidden = false
        } else {
            switcher.isHidden = true
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    //MARK: - Custom Switcher method
    @objc func changeTheme() {
        delegate?.changeTheme()
        print("Hello")
    }
}
