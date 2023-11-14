//
//  ExecuteToDoController.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 14.11.2023.
//

import UIKit

class ExecuteToDoController: UITableViewController {
    
    //MARK: - Elements
    var presenter: ExecuteToDoPresenterProtocol?
    var executeToDos: [ToDoItem] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    //MARK: - Lifecycle
    override func viewDidAppear(_ animated: Bool) {
        presenter?.viewWillAppear()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK: - Setup Elements
    private func setupView() {
        view.backgroundColor = .systemBackground
        title = "Завершенные"
        navigationController?.navigationBar.prefersLargeTitles = true
        self.tableView.register(ToDoCell.self, forCellReuseIdentifier: ToDoCell.reuseIdentifier)
        self.tableView.showsVerticalScrollIndicator = false
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return executeToDos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ToDoCell.reuseIdentifier, for: indexPath) as? ToDoCell
        cell?.setupElements(with: executeToDos[indexPath.row])
        
        return cell ?? UITableViewCell()
    }
}

extension ExecuteToDoController: ExecuteToDoViewProtocol {
    func showExcuteToDos(_ toDo: [ToDoItem]) {
        self.executeToDos = toDo
    }
}
