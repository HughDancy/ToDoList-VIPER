//
//  ToDoListViewController.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 08.11.2023.
//

import UIKit

class ToDoListViewController: UITableViewController {

    // MARK: - Elements
    var presenter: ToDoListPresenterProtocol?
    var toDos: [[ToDoObject]] = [[]] {
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

    // MARK: - Lifecycle
    override func viewDidAppear(_ animated: Bool) {
        presenter?.viewWillAppear()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Задачи"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupRightBarButton()
        setupView()
        view.backgroundColor = .systemBackground
    }

    deinit {
        print("ToDoListController is ☠️")
    }

    // MARK: - Setup NavBar Button
    private func setupRightBarButton() {
        let menuBarItem = UIBarButtonItem(customView: addButton)
        self.navigationItem.rightBarButtonItem = menuBarItem
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    // MARK: - Setup Elements
    private func setupView() {
        self.tableView.register(ToDosCell.self, forCellReuseIdentifier: ToDosCell.reuseIdentifier)
        self.tableView.showsVerticalScrollIndicator = false
    }

    @objc func addToDo() {
        self.presenter?.showAddToDo()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return toDos.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDos[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ToDosCell.reuseIdentifier, for: indexPath) as? ToDosCell
        cell?.setupElements(with: toDos[indexPath.section][indexPath.row])
        cell?.doneCheckDelegate = self
        cell?.numberOfRow = indexPath.row
        cell?.numberOfSection = indexPath.section

        return cell ?? UITableViewCell()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let toDo = toDos[indexPath.section][indexPath.row]
        presenter?.showToDoDetail(toDo)
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let toDo = toDos[indexPath.section][indexPath.row]
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            presenter?.removeToDo(toDo)
            tableView.endUpdates()
        }
    }
}

// MARK: - ToDoListViewProtocol Extension
extension ToDoListViewController: ToDoListViewProtocol {
    func showToDos(_ toDos: [[ToDoObject]]) {
        self.toDos = toDos
    }
}

// MARK: - ToDoDoneProtocol Extension
extension ToDoListViewController: ToDoDoneProtocol {
    func doneToDo(with index: Int, and section: Int) {
        let pathIndex = IndexPath(item: index, section: section)
        tableView.beginUpdates()
        presenter?.doneToDo(toDos[section][index])
        tableView.deleteRows(at: [pathIndex], with: .fade)
        tableView.endUpdates()
    }
}
