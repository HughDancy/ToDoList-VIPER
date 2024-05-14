//
//  CathegoryTableView.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 27.04.2024.
//

import UIKit

class CategoryTableView: UITableView {
    
    lazy var categories: [TaskCategory] = {
        let categories = TaskCategoryManager.manager.fetchCategories()
        return categories
    }()
    
    init(frame: CGRect, style: UITableView.Style, color: UIColor) {
        super.init(frame: frame, style: style)
        self.backgroundColor = color
        setupTable()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup Table
    private func setupTable() {
        dataSource = self
        isScrollEnabled = false
        showsVerticalScrollIndicator = false
        separatorStyle = .none
        register(CategoryCell.self, forCellReuseIdentifier: CategoryCell.reuseIdentifier)
    }
}

extension CategoryTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.reuseIdentifier, for: indexPath) as? CategoryCell else {
            return UITableViewCell()
        }
        let category = categories[indexPath.row]
        cell.backgroundColor = UIColor(named: "coralColor")
        cell.setupCell(with: category.color, title: category.title)
        return cell
    }
}
