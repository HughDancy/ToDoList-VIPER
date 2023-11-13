//
//  ToDoDetailController.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 13.11.2023.
//

import UIKit
import SnapKit

class ToDoDetailController: UIViewController {
    
    var presenter: ToDoDetailPresenterProtocol?
    
    //MARK: - Outlets
    private lazy var titleLabel: UITextField = {
        let label = UITextField()
        label.borderStyle = .none
        label.isUserInteractionEnabled = false
        
        return label
    }()
    
    private lazy var contentLabel: UITextField = {
        let label = UITextField()
        label.borderStyle = .none
        label.isUserInteractionEnabled = false
        
        return label
    }()
    
    private lazy var editButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(editToDo), for: .touchDown)
        
        return button
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(saveToDo), for: .touchDown)
        button.isHidden = true
        return button
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Delete", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(deleteToDo), for: .touchDown)
        
        return button
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupHierarchy()
        setupLayout()
        
    }
    
    //MARK: - Setup Outlets
    private func setupHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(contentLabel)
        view.addSubview(editButton)
        view.addSubview(saveButton)
        view.addSubview(deleteButton)
    }
    
    private func setupLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(10)
        }
        
        editButton.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(10)
            make.height.equalTo(40)
            make.width.equalTo(50)
        }
        
        saveButton.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(10)
            make.height.equalTo(43)
            make.width.equalTo(50)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(10)
            make.height.equalTo(40)
            make.width.equalTo(50)
        }
    }
    
    @objc func editToDo() {
        editButton.isHidden = true
        saveButton.isHidden = false
        titleLabel.isUserInteractionEnabled = true
        contentLabel.isUserInteractionEnabled = true
    }

    @objc func deleteToDo() {
        presenter?.deleteToDo()
    }
    
    @objc func saveToDo() {
        saveButton.isHidden = true
        editButton.isHidden = false
        titleLabel.isUserInteractionEnabled = false
        contentLabel.isUserInteractionEnabled = false
        presenter?.editToDo(title: titleLabel.text ?? "", content: contentLabel.text ?? "")
        
    }
    
}

extension ToDoDetailController: ToDoDetailViewProtocol {
    func showToDo(_ toDo: ToDoItem) {
        titleLabel.text = toDo.title
        contentLabel.text = toDo.content
    }
}
