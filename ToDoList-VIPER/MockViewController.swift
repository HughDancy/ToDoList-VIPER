//
//  MockViewController.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 16.01.2024.
//

import UIKit

class MockViewController: UIViewController {
    
    private lazy var mockImage: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "wrench.and.screwdriver.fill")
        imageView.image = image
        imageView.backgroundColor = .systemPink
        imageView.tintColor = .systemBackground
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        setupMockImage()
    }
    
    private func setupMockImage() {
        view.addSubview(mockImage)
        mockImage.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(view.safeAreaLayoutGuide)
            make.height.width.equalTo(100)
        }
    }
}
