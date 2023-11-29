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
    var executeToDos: [ToDoObject] = [] {
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
        title = "Завершено"
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
        cell?.executeToDo()
        return cell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let toDo = executeToDos[indexPath.row]
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            presenter?.removeToDo(toDo)
            tableView.endUpdates()
        }
    }
}

extension ExecuteToDoController: ExecuteToDoViewProtocol {
    func showExcuteToDos(_ toDo: [ToDoObject]) {
        self.executeToDos = toDo
    }
}
