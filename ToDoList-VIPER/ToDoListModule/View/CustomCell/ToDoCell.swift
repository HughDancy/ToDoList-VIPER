//
//  ToDoCell.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 09.11.2023.
//

import UIKit
import SnapKit

class ToDoCell: UITableViewCell {
    
    static let reuseIdentifier = "ToDoCell"
    
    //MARK: - Elements
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var bodyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup Elements
    private func setupHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(bodyLabel)
    }
    
    private func setupLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }
        
        bodyLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom).inset(5)
        }
    }
    
    func setupElements(with model: ToDoItem) {
        titleLabel.text = model.title
        bodyLabel.text = model.content
    }
    
    override func prepareForReuse() {
        titleLabel.text = nil
        bodyLabel.text = nil
    }
    
}
