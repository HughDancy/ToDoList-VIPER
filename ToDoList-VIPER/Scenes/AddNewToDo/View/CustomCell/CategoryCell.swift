//
//  CathegoryCell.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 20.03.2024.
//

import UIKit

class CategoryCell: UITableViewCell {
    static let reuseIdentifier = "CathegoryCell"
    
    //MARK: - OUTELTS
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = UIScreen.main.bounds.height > 700 ? 10 :  7
        view.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        view.layer.shadowRadius = 3
        view.layer.shadowColor = UIColor.systemBackground.cgColor
        view.layer.shadowOpacity = 0.2
        
        return view
    }()
    
    private lazy var cathegoryLabel = UILabel.createSimpleLabel(text: "", size: 15, width: .semibold, color: .label)
    
    private lazy var circleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = UIScreen.main.bounds.height > 700 ? 20 :  15
        view.clipsToBounds = true
        return view
    }()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupOutlets()
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if self.isSelected {
            containerView.layer.borderWidth = 2
            containerView.layer.borderColor = UIColor.systemBlue.cgColor
        } else {
            containerView.layer.borderWidth = 0
        }
    }
    
    private func setupOutlets() {
        setupHierarcy()
        setupLayout()
    }
    
    //MARK: - Setup Hierarchy
    private func setupHierarcy() {
        contentView.addSubview(containerView)
        containerView.addSubview(cathegoryLabel)
        containerView.addSubview(circleView)
    }
    
    //MARK: - Setup Layout
    private func setupLayout() {
        containerView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview().inset(5)
        }
        
        cathegoryLabel.snp.makeConstraints { make in
            make.centerY.equalTo(containerView.safeAreaLayoutGuide.snp.centerY)
            make.leading.equalTo(containerView.safeAreaLayoutGuide.snp.leading).offset(10)
        }
        
        circleView.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(5)
            make.trailing.equalTo(containerView.snp.trailing).inset(10)
            make.bottom.equalTo(containerView.snp.bottom).inset(5)
            make.height.width.equalTo(UIScreen.main.bounds.height > 700 ? 40 :  30)
        }
    }
    
    func setupCell(with color: UIColor, title: String) {
        self.circleView.backgroundColor = color
        self.cathegoryLabel.text = title
    }
}

