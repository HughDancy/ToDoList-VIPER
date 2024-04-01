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
    var isDone: Bool = false
    var index: Int = 0
    
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
        imageView.tintColor = imageView.isHighlighted ? .systemGreen : .label
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var taskName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
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
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
        if self.isSelected {
           
        }
    }
    
    override func prepareForReuse() {
        checkboxImage.isHighlighted = false
        checkboxImage.tintColor = .black
        taskName.text = "Temp"
    }
    
    //MARK: - Setup Hierarchy
    private func setupHierachy() {
        iconBox.addSubview(icon)
        contentView.addSubview(container)
        container.addSubview(checkboxImage)
        container.addSubview(taskName)
        container.addSubview(iconBox)
//        iconBox.addSubview(icon)
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
            make.top.equalToSuperview().offset(20)
            make.leading.equalTo(checkboxImage.snp.trailing).offset(20)
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

    //MARK: - Setup cell
    func setupCell(with title: String, boxColor: UIColor, doneStatus: Bool, index: Int) {
        self.taskName.text = title
        self.iconBox.backgroundColor = boxColor
        self.index = index
        switch boxColor {
        case .systemOrange:
            self.icon.image = UIImage(systemName: "bag")
        case .systemGreen:
            self.icon.image = UIImage(systemName: "person")
        case .systemPurple:
            self.icon.image = UIImage(systemName: "folder")
        default:
            self.icon.image = UIImage(systemName: "lightbulb")
        }
        
//        if doneStatus == true  {
//            self.makeItDone()
//        }
    }
}

//MARK: - Tap Gesture to Checkbox image Extension
extension ToDoCell {
    private func addTapRecognizerToImage() {
        self.checkboxImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapToImage)))
    }

    @objc private func tapToImage(_ sender: UIGestureRecognizer) {
        self.isDone = true
//        let doneTaskInfo: [String : Int] = ["doneStatus" : self.index]
//        NotificationCenter.default.post(name: Notification.Name("DoneTask"), object: nil, userInfo: doneTaskInfo)
        self.makeItDone()
    }
    
    func makeItDone() {
        checkboxImage.tintColor = .systemGreen
        checkboxImage.isHighlighted = true
        checkboxImage.isUserInteractionEnabled = false
        
        let attributedText : NSMutableAttributedString =  NSMutableAttributedString(string: taskName.text ?? "Temp")
        attributedText.addAttributes([
                        NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue,
                        NSAttributedString.Key.strikethroughColor: UIColor.systemGreen,
                        NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15.0, weight: .semibold)
                        ], range: NSMakeRange(0, attributedText.length))
        taskName.attributedText = attributedText
    }
}
