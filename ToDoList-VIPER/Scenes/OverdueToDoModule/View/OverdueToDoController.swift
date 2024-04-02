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
            setupHideWellDone()
        }
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(ToDosCell.self, forCellReuseIdentifier: ToDosCell.reuseIdentifier)
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
        label.text = "У Вас отсутствуют просроченные задачи. Так держать!"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .systemBlue
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    //MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Просроченные"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupHierarchy()
        setupLayout()
    }
    
    //MARK: - Setup Elements
    private func setupHierarchy() {
        view.addSubview(tableView)
        view.addSubview(wellDoneImage)
        view.addSubview(wellDoneLabel)
    }
    
    private func setupLayout() {
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        wellDoneImage.snp.makeConstraints { make in
            make.centerY.equalTo(view.safeAreaLayoutGuide.snp.centerY)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(50)
            make.height.equalTo(view.bounds.height / 4)
        }
        
        wellDoneLabel.snp.makeConstraints { make in
            make.top.equalTo(wellDoneImage.snp.bottom).offset(10)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
    }
    
    private func setupHideWellDone() {
        if ToDoObjectSorter.sortByVoid(object: toDos) {
            wellDoneImage.isHidden = false
            wellDoneLabel.isHidden = false
            tableView.isHidden = true
            tableView.tableHeaderView?.isHidden = true
        } else {
            wellDoneImage.isHidden = true
            wellDoneLabel.isHidden = true
            tableView.isHidden = false
            tableView.tableHeaderView?.isHidden = false
        }
    }
}

//MARK: - TableView Delegate Extension
extension OverdueToDoController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return toDos.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDos[section].count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Вчера"
        case 1:
            return "Позавчера"
        default:
            return "Ранее"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ToDosCell.reuseIdentifier, for: indexPath) as? ToDosCell
        cell?.setupElements(with: toDos[indexPath.section][indexPath.row])
        cell?.overdueToDo()
        cell?.numberOfSection = indexPath.section
        cell?.numberOfRow = indexPath.row
        cell?.doneCheckDelegate = self
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let toDo = toDos[indexPath.section][indexPath.row]
        presenter?.showToDetail(toDo)
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

//MARK: - OverdueViewProtocol Extension
extension OverdueToDoController: OverdueViewProtocol {
    func showToDos(_ toDos: [[ToDoObject]]) {
        self.toDos = toDos
    }
}

//MARK: - DoneToDoDelegate
extension OverdueToDoController: ToDoDoneProtocol {
    func doneToDo(with index: Int, and section: Int) {
        let pathIndex = IndexPath(item: index, section: section)
        tableView.beginUpdates()
        presenter?.doneToDo(toDos[section][index])
        tableView.deleteRows(at: [pathIndex], with: .fade)
        tableView.endUpdates()
    }
}
