//
//  ToDoCell.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 09.11.2023.
//

import UIKit
import SnapKit

class ToDoCell: UITableViewCell {
    
    weak var doneCheckDelegate: ToDoDoneProtocol?
    static let reuseIdentifier = "ToDoCell"
    var numberOfRow = -1
    
    //MARK: - Elements
    private lazy var checkImage: UIImageView = {
        let circleImage = UIImage(systemName: "circle")
        let doneImage = UIImage(systemName: "checkmark.circle")
        let imageView = UIImageView(image: circleImage, highlightedImage: doneImage)
        imageView.isHighlighted = false
        imageView.tintColor = .systemGreen
        
        return imageView
    }()
    
    private lazy var doneButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.tintColor = .clear
        button.addTarget(self, action: #selector(makeItDone), for: .touchDown)
        
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        label.textColor = .systemCyan
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
        contentView.addSubview(doneButton)
        contentView.addSubview(checkImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(bodyLabel)
    }
    
    private func setupLayout() {
        doneButton.snp.makeConstraints { make in
            make.top.leading.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.width.equalTo(45)
        }
        
        checkImage.snp.makeConstraints { make in
            make.top.leading.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.width.equalTo(45)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalTo(checkImage.snp.trailing).offset(15)
        }
        
        bodyLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalTo(checkImage.snp.trailing).offset(15)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom).inset(5)
        }
    }
    
    func setupElements(with model: ToDoObject) {
        titleLabel.text = model.title
        bodyLabel.text = model.dateTitle
    }
    
    func executeToDo() {
        checkImage.isHighlighted = true
        doneButton.isHidden = true
    }
    
    @objc func makeItDone() {
        if checkImage.isHighlighted == false  {
            checkImage.isHighlighted = true
            doneCheckDelegate?.doneToDo(with: self.numberOfRow)
        }
    }

    override func prepareForReuse() {
        titleLabel.text = nil
        bodyLabel.text = nil
        checkImage.isHighlighted = false
    }
    
}
