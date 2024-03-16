//
//  ColorsCell.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 16.03.2024.
//

import UIKit

class ColorsCell: UICollectionViewCell {
    static let reuseIdentidier = "ColorsCell"
    
    //MARK: - OUTELTS
    private lazy var circleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 25
        view.clipsToBounds = true
        return view
    }()
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        setupOutlets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Setup Outlets
    private func setupOutlets() {
        contentView.addSubview(circleView)
        setupLayout()
    }
    
    private func setupLayout() {
        circleView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.width.equalTo(50)
        }
    }
    
    func setupCell(with color: UIColor) {
        self.circleView.backgroundColor = color
    }
}
