//
//  ToDoListController.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 28.11.2023.
//

import UIKit
import SnapKit

class ToDoListController: UIViewController {
    
    //MARK: - Element's
    var presenter: ToDoListPresenter?
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.register(ToDoCell.self, forCellReuseIdentifier: ToDoCell.reuseIdentifier)
        table.showsVerticalScrollIndicator = false
        table.delegate = self
        table.dataSource = self
        
        return table
    }()
    
    private lazy var noToDoImage: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "tray")
        imageView.image = image
        imageView.tintColor = .systemBlue
        return imageView
    }()
    
    private lazy var noToDoLabel: UILabel = {
        let label = UILabel()
        label.text = "Ничего не запланировано"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .systemBlue
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var noToDoStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    private lazy var addToDoButton: UIButton = {
        let button = UIButton(type: .custom)
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .large)
        let largeAddImage = UIImage(systemName: "plus.circle.fill", withConfiguration: largeConfig)
        button.setImage(largeAddImage, for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(addToDo), for: .touchDown)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Звпланировано"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupHierarchy()
        setupLayout()
        
        // Do any additional setup after loading the view.
    }
    
    
    //MARK: - Setup Element's
    private func setupHierarchy() {
        
    }
    
    private func setupLayout() {
        
    }
    
    //MARK: - Button Action
    @objc func addToDo() {
        
    }
}

//MARK: - TableView Delegate Extension
extension ToDoListController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ToDoCell.reuseIdentifier, for: indexPath) as? ToDoCell
        
        return cell ?? UITableViewCell()
    }
    
    
}
