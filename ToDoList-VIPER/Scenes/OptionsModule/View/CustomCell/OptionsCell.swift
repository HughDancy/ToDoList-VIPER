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

    //MARK: - Elements
    private lazy var icon: UIImageView = {
       let icon = UIImageView()
        
        return icon
    }()
    
    private lazy var title: UILabel = {
       let label = UILabel()
        
        return label
    }()
    
    private lazy var  container: UIView = {
       let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
   //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .systemBackground
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup Elements
    private func setupHierarchy() {
        contentView.addSubview(container)
        container.addSubview(icon)
        container.addSubview(title)
    }
    
    private func setupLayout() {
        container.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }
        
        icon.snp.makeConstraints { make in
            make.centerX.equalTo(contentView.snp.centerX)
            make.leading.equalTo(container.snp.leading).offset(10)
        }
        
        title.snp.makeConstraints { make in
            make.centerX.equalTo(contentView.snp.centerX)
            make.leading.equalTo(icon.snp.trailing).offset(10)
        }
        
    }
    
    func setupElements() {
        
    }
    
}
