//
//  ToDoCell.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 25.03.2024.
//

import UIKit
import SnapKit

class ToDoCell: UITableViewCell {
    
    //MARK: - Class custom properties
    static let reuseIdentifier = "ToDoCell"
    var toDoItem: ToDoObject?
    
    //MARK: - Outlets
    private lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    var checkboxImage: UIImageView = {
        let image = UIImage(systemName: "square")
        let highlaghtedImage = UIImage(systemName: "checkmark.square")
        let imageView = UIImageView(image: image, highlightedImage: highlaghtedImage)
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var taskName: UILabel = {
        let label = UILabel.createSimpleLabel(text: "", size: 15, width: .semibold, color: .label, aligment: .left, numberLines: 0)
        label.numberOfLines = 0
        label.lineBreakMode = .byClipping
        return label
    }()
    
    private lazy var iconBox: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var icon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = iconBox.backgroundColor
        imageView.tintColor = .systemBackground
        return imageView
    }()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        setupHierachy()
        setupLayout()
        addTapRecognizerToImage()
        self.backgroundColor = UIColor(named: "tasksBackground")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
        self.isUserInteractionEnabled = true
    }
    
    override func prepareForReuse() {
        checkboxImage.isHighlighted = false
        checkboxImage.image = UIImage(systemName: "square")
        checkboxImage.tintColor = .black
        taskName.text = nil
    }
    
    //MARK: - Setup Hierarchy
    private func setupHierachy() {
        contentView.addSubview(container)
        container.addSubview(checkboxImage)
        container.addSubview(taskName)
        container.addSubview(iconBox)
        iconBox.addSubview(icon)
    }
    
    //MARK: - Setup Layout
    private func setupLayout() {
        container.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview().inset(5)
        }
        
        checkboxImage.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview().inset(10)
            make.height.width.equalTo(50)
        }
        
        taskName.snp.makeConstraints { make in
            make.centerX.equalTo(container.safeAreaLayoutGuide.snp.centerX)
            make.top.equalToSuperview().offset(10)
            make.leading.equalTo(checkboxImage.snp.trailing).offset(20)
            make.trailing.equalTo(iconBox.snp.leading).offset(-5)
            make.bottom.equalTo(container.snp.bottom).inset(10)
        }
        
        iconBox.snp.makeConstraints { make in
            make.top.equalTo(container.safeAreaLayoutGuide.snp.top).offset(-5)
            make.trailing.bottom.equalTo(container).offset(5)
            make.width.equalTo(100)
        }
        
        icon.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(iconBox)
            make.height.width.equalTo(50)
        }
    }
    
    //MARK: - Setup cell methods
    func setupCell(with item: ToDoObject, status: ToDoListStatus) {
        switch status {
        case .today, .tommorow, .done:
            self.setupStandartCell(with: item)
        case .overdue:
            self.setupOverdueCell(with: item)
        }
    }
    
    private func setupStandartCell(with item: ToDoObject) {
        if item.isOverdue {
            self.setupOverdueCell(with: item)
        } else {
            self.basicSetupCell(with: item)
            
            if item.doneStatus == true {
                self.makeItDone()
            } else {
                checkboxImage.isHighlighted = false
                checkboxImage.tintColor = .label
                taskName.strikeThrough(false)
                self.checkboxImage.isUserInteractionEnabled = true
            }
        }
    }
    
    private func basicSetupCell(with item: ToDoObject) {
        self.taskName.text = item.title
        self.iconBox.backgroundColor = item.color
        self.toDoItem = item
        self.icon.image = UIImage(systemName: item.iconName ?? "moon.fill")
    }
    
    private func setupOverdueCell(with item: ToDoObject) {
        self.basicSetupCell(with: item)
        checkboxImage.isHighlighted = false
        checkboxImage.image = UIImage(systemName: "xmark.square")
        checkboxImage.tintColor = .systemRed
        taskName.strikeThrough(false)
        self.checkboxImage.isUserInteractionEnabled = true
    }
}

//MARK: - Tap Gesture to Checkbox image Extension
extension ToDoCell {
    private func addTapRecognizerToImage() {
        self.checkboxImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapToImage)))
    }
    
    @objc private func tapToImage(_ sender: UIGestureRecognizer) {
        if self.toDoItem?.doneStatus == false {
            self.makeItDone()
            let userInfo: [String: ToDoObject?] = ["doneItem" : self.toDoItem]
            NotificationCenter.default.post(name: NotificationNames.doneToDo.name, object: nil, userInfo: userInfo as [AnyHashable : Any])
        }
    }
    
    func makeItDone() {
        checkboxImage.tintColor = .systemGreen
        checkboxImage.isHighlighted = true
        checkboxImage.isUserInteractionEnabled = false
        taskName.strikeThrough(true)
    }
}
