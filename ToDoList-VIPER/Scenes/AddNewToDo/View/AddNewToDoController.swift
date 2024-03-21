//
//  AddNewToDoController.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 15.03.2024.
//

import UIKit

class AddNewToDoController: UIViewController, AddNewToDoViewProtocol, UITableViewDelegate {
    private var color: ColorsItemResult?
    var presenter: AddNewToDoPresenterProtocol?
    
    private var addNewToDoView: AddNewToDoView? {
        guard isViewLoaded else { return nil }
        return view as? AddNewToDoView
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view = AddNewToDoView()
        setupViewOutlets()
    }
    
    //MARK: - Setup View Outelets
    func setupViewOutlets() {
        addNewToDoView?.cathegoryList.delegate = self
        addNewToDoView?.cathegoryList.dataSource = self
        addNewToDoView?.addNewToDoButton.addTarget(self, action: #selector(addNewToDo), for: .touchDown)
        addNewToDoView?.closeButton.addTarget(self, action: #selector(dismissToMain), for: .touchDown)
    }
    
    //MARK: - Buttons Action
    @objc func addNewToDo() {
        presenter?.addNewToDo(with: addNewToDoView?.nameOfTaskField.text,
                              description: addNewToDoView?.descriptionField.text,
                              date: addNewToDoView?.dateField.date,
                              mark: color?.rawValue ?? ColorsItemResult.systemPurple.rawValue)
    }
    
    @objc func dismissToMain() {
        presenter?.goBackToMain()
    }
    
    //    @objc func removeTextInTextView() {
    //        self.descriptionField.text = ""
    //    }
}

//MARK: - TableViewDelegate Extension
extension AddNewToDoController: UITabBarDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ColorsItem.colorsStack.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CathegoryCell.reuseIdentifier, for: indexPath) as? CathegoryCell
        let cathegoryName = ["Работа", "Личное", "Иное"]
        cell?.setupCell(with: ColorsItem.colorsStack[indexPath.row], title: cathegoryName[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch ColorsItem.colorsStack[indexPath.row] {
        case .systemOrange:
            self.color = ColorsItemResult.systemOrange
        case .systemGreen:
            self.color = ColorsItemResult.systemGreen
        case .systemPurple:
            self.color = ColorsItemResult.systemPurple
        default:
            self.color = ColorsItemResult.systemOrange
        }
    }
    
}
