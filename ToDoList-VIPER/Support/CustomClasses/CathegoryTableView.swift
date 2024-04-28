//
//  CathegoryTableView.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 27.04.2024.
//

import UIKit

class CathegoryTableView: UITableView {
    
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
        register(CathegoryCell.self, forCellReuseIdentifier: CathegoryCell.reuseIdentifier)
    }
}

extension CathegoryTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ColorsItem.colorsStack.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CathegoryCell.reuseIdentifier, for: indexPath) as? CathegoryCell else {
            return UITableViewCell()
        }
        let cathegoryName = ["Работа", "Личное", "Иное"]
        cell.backgroundColor = UIColor(named: "coralColor")
        cell.setupCell(with: ColorsItem.colorsStack[indexPath.row], title: cathegoryName[indexPath.row])
        return cell
    }
}
