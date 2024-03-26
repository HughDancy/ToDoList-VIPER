//
//  ToDoController.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 25.03.2024.
//

import UIKit
import SnapKit

final class ToDoController: UIViewController {
    

    //MARK: - Outlets
    private lazy var toDoTable: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .systemBackground
        tableView.register(ToDoCell.self, forCellReuseIdentifier: ToDosCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        return tableView
        
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupHierarchy()
        setupLayot()
       
    }
    
    //MARK: - Setup Hierarchy
    private func setupHierarchy() {
        view.addSubview(toDoTable)
    }
    
    //MARK: - Setup Layout
    private func setupLayot() {
        toDoTable.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
  
}

extension ToDoController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ToDoItems.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ToDoCell.reuseIdentifier, for: indexPath) as? ToDoCell
        cell?.setupCell(with: ToDoItems.items[indexPath.row].title,
                        boxColor: ToDoItems.items[indexPath.row].color,
                        icon: ToDoItems.items[indexPath.row].nameOfImage)
        return cell ?? UITableViewCell()
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        120
//    }
}

struct ToDoItems {
    var title: String
    var color: UIColor
    var nameOfImage: String
}

extension ToDoItems {
    static let items = [
    ToDoItems(title: "working on code",
              color: .systemOrange,
              nameOfImage: "bag"),
    ToDoItems(title: "good sleep",
              color: .systemGreen,
              nameOfImage: "person"),
    ToDoItems(title: "buy Nintendo",
              color: .systemPurple,
              nameOfImage: "folder"),
    ToDoItems(title: "working on code twice",
              color: .systemOrange,
              nameOfImage: "bag")
    ]
}
