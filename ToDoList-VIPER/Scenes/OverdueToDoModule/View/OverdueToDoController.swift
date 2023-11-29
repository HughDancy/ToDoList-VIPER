//
//  OverdueToDoController.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 29.11.2023.
//

import UIKit
import SnapKit

class OverdueToDoController: UIViewController {

    //MARK: - Elements
    var presenter: OverduePresenterProtocol?
    var toDos: [[ToDoObject]] = [[]] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(ToDoCell.self, forCellReuseIdentifier: ToDoCell.reuseIdentifier)
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private lazy var wellDoneImage: UIImageView = {
        let imageView = UIImageView()
        let picture = UIImage(systemName: "hand.thumbsup.fill")
        imageView.image = picture
        imageView.tintColor = .systemBlue
        return imageView
    }()
    
    private lazy var wellDoneLabel: UILabel = {
        let label = UILabel()
        label.text = "У Вас отсутствуют просроченные задачи"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .systemBlue
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Просроченные"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupHierarchy()
        setupLayout()
    }
    
    //MARK: - Setup Elements
    private func setupHierarchy() {
        
    }
    
    private func setupLayout() {
        
    }



}


//MARK: - TableView Delegate Extension
extension OverdueToDoController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        return cell
    }
    
    
}

//MARK: - OverdueViewProtocol Extension
extension OverdueToDoController: OverdueViewProtocol {
    func showToDos(_ toDos: [[ToDoObject]]) {
        self.toDos = toDos
    }
    
    
}
