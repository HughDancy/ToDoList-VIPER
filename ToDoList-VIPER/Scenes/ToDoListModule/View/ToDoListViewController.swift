//
//  ToDoListViewController.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 08.11.2023.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    //MARK: - Elements
    var presenter: ToDoListPresenterProtocol?
    var toDos: [ToDoItem] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private lazy var addButton: UIButton = {
        let button = UIButton(type: .custom)
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .large)
        let largeAddImage = UIImage(systemName: "plus.circle.fill", withConfiguration: largeConfig)
        button.setImage(largeAddImage, for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(addToDo), for: .touchDown)
        return button
    }()
    
    //MARK: - Lifecycle
    override func viewDidAppear(_ animated: Bool) {
        presenter?.viewWillAppear()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Запланировано"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupRightBarButton()
        setupView()
        view.backgroundColor = .systemBackground
    }
    
    //MARK: - Setup NavBar Button
    private func setupRightBarButton() {
        let menuBarItem = UIBarButtonItem(customView: addButton)
        self.navigationItem.rightBarButtonItem = menuBarItem
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    //MARK: - Setup Elements
    private func setupView() {
        self.tableView.register(ToDoCell.self, forCellReuseIdentifier: ToDoCell.reuseIdentifier)
        self.tableView.showsVerticalScrollIndicator = false
    }
    
    @objc func addToDo() {
        self.presenter?.showAddToDo()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ToDoCell.reuseIdentifier, for: indexPath) as? ToDoCell
        cell?.setupElements(with: toDos[indexPath.row])
        cell?.doneCheckDelegate = self
        cell?.numberOfRow = indexPath.row
    
        return cell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let toDo = toDos[indexPath.row]
        presenter?.showToDoDetail(toDo)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let toDo = toDos[indexPath.row]
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            presenter?.removeToDo(toDo)
            tableView.endUpdates()
        }
    }
}

//MARK: - ToDoListViewProtocol Extension
extension ToDoListViewController: ToDoListViewProtocol {
    func showToDos(_ toDos: [ToDoItem]) {
        self.toDos = toDos
    }
}

//MARK: - ToDoDoneProtocol Extension
extension ToDoListViewController: ToDoDoneProtocol {
    func doneToDo(with index: Int) {
        let pathIndex = IndexPath(item: index, section: 0)
        tableView.beginUpdates()
        presenter?.doneToDo(toDos[index])
        tableView.deleteRows(at: [pathIndex], with: .middle)
        tableView.endUpdates()
    }
}
