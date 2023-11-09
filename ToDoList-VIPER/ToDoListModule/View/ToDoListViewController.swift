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
    
    private func setupView() {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    @objc func addToDo() {
        let alertController = UIAlertController(title: "Add Todo Item", message: "Enter title and content", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: nil)
        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { [weak self](_) in
            let titleText = alertController.textFields![0].text ?? ""
            let contentText = alertController.textFields![1].text ?? ""
            guard !titleText.isEmpty else { return }
            let todoItem = ToDoItem(title: titleText, content: contentText)
            self?.presenter?.addToDo(todoItem)
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = toDos[indexPath.row].title
//        cell.detailTextLabel?.text = toDos[indexPath.row].content
        cell.detailTextLabel?.text = "Body"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let toDo = toDos[indexPath.row]
        presenter?.showToDoDetail(toDo)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let toDo = toDos[indexPath.row]
            presenter?.removeToDo(toDo)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

//MARK: - ToDoListViewProtocol Extension
extension ToDoListViewController: ToDoListViewProtocol {
    func showToDos(_ toDos: [ToDoItem]) {
        self.toDos = toDos
    }
    
    func showErrorMessage(_ message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
