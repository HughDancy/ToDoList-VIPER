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
    var presenter: ToDoListPresenterProtocol?
    var toDos: [[ToDoObject]] = [[]] {
        didSet {
            tableView.reloadData()
            setupNoToDo()
        }
    }
    
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
        label.text = "У Вас отсутствуют заплаинрованные задачи"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .systemBlue
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Звпланировано"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupHierarchy()
        setupLayout()
        setupRightBarButton()
    }
    
    //MARK: - Setup Element's
    private func setupHierarchy() {
        view.addSubview(tableView)
        view.addSubview(noToDoImage)
        view.addSubview(noToDoLabel)
    }
    
    private func setupLayout() {
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        noToDoImage.snp.makeConstraints { make in
            make.centerY.equalTo(view.safeAreaLayoutGuide.snp.centerY)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.height.equalTo(view.bounds.height / 4)
        }
        
        noToDoLabel.snp.makeConstraints { make in
            make.top.equalTo(noToDoImage.snp.bottom).offset(10)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
    }
    
    private func setupRightBarButton() {
        let menuBarItem = UIBarButtonItem(customView: addToDoButton)
        self.navigationItem.rightBarButtonItem = menuBarItem
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupNoToDo() {
        if toDos.isEmpty  {
            noToDoImage.isHidden = false
            noToDoLabel.isHidden = false
        } else {
            noToDoImage.isHidden = true
            noToDoLabel.isHidden = true
        }
    }
    
    //MARK: - Button Action
    @objc func addToDo() {
        self.presenter?.showAddToDo()
    }
}

    //MARK: - TableView Delegate Extension
extension ToDoListController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return toDos.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDos[section].count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Сегодня"
        case 1:
            return "Завтра"
        default:
            return "Позже"
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ToDoCell.reuseIdentifier, for: indexPath) as? ToDoCell
        cell?.setupElements(with: toDos[indexPath.section][indexPath.row])
        cell?.doneCheckDelegate = self
        cell?.numberOfRow = indexPath.row
        cell?.numberOfSection = indexPath.section
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let toDo = toDos[indexPath.section][indexPath.row]
        presenter?.showToDoDetail(toDo)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let toDo = toDos[indexPath.section][indexPath.row]
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            presenter?.removeToDo(toDo)
            
            tableView.endUpdates()
        }
    }
}

//MARK: - ToDoListViewProtocol Extension
extension ToDoListController: ToDoListViewProtocol {
    
    func showToDos(_ toDos: [[ToDoObject]]) {
        self.toDos = toDos
    }
}

//MARK: - DoneToDoProtocol
extension ToDoListController: ToDoDoneProtocol {
    func doneToDo(with index: Int, and section: Int) {
        let pathIndex = IndexPath(item: index, section: section)
        tableView.beginUpdates()
        presenter?.doneToDo(toDos[section][index])
        tableView.deleteRows(at: [pathIndex], with: .fade)
        tableView.endUpdates()
    }
}
