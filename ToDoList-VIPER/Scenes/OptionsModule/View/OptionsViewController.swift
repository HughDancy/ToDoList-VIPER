//
//  OptionsViewController.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 02.12.2023.
//

import UIKit

class OptionsViewController: UIViewController {
   
    var presenter: OptionsPresenterProtocol?
    var items = [OptionsItems]()
    
    //MARK: - Elements
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.delegate = self
        table.dataSource = self
        table.register(OptionsHeader.self, forHeaderFooterViewReuseIdentifier: OptionsHeader.reuseIdentifier)
        table.register(OptionsCell.self, forCellReuseIdentifier: OptionsCell.reuseIdentifier)
        table.separatorStyle = .none
        
        return table
    }()

    //MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
        view?.overrideUserInterfaceStyle = ToDoUserDefaults.shares.theme.getUserInterfaceStyle()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Настройки"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .systemGroupedBackground
        view.backgroundColor = .systemBackground
        setupHierarchy()
        setupLayout()
        
    }
    
    //MARK: - Setup Elements
    private func setupHierarchy() {
        view.addSubview(tableView)
    }
    
    private func setupLayout() {
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

//MARK: - TableDelegates extension

extension OptionsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //MARK: - ПЕРЕДЕЛАТЬ МЕТОД ПОД РОУТЕР ИЛИ ВРЕМЕННОЕ ХРАНИЛИЩЕ ЧЕРЕЗ РОУТЕР
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: OptionsHeader.reuseIdentifier) as? OptionsHeader
        header?.goUserOptionsDelegate = self
        header?.setupElements(with: ToDoUserDefaults.shares.nickname)
        return header
    }
    
//    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
//        return 200
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return OptionsItems.options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OptionsCell.reuseIdentifier, for: indexPath) as? OptionsCell
        cell?.setupElements(text: items[indexPath.row].title, image: items[indexPath.row].icon, index: indexPath.row)
        cell?.delegate = self
        return cell ?? UITableViewCell()
    }

}

extension OptionsViewController: OptionsViewProtocol {
    func getOptionsData(items: [OptionsItems]) {
        self.items = items
    }
}

extension OptionsViewController: SwitchThemeProtocol {
    func changeUserTheme(with bool: Bool) {
        presenter?.changeTheme(with: bool)
        view?.overrideUserInterfaceStyle = ToDoUserDefaults.shares.theme.getUserInterfaceStyle()
    }
}

extension OptionsViewController: GoToUserOptionsProtocol {
    func goToUserOptions() {
        presenter?.goToUserOptions()
    }
}
