//
//  ToDosDetailController.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 02.04.2024.
//

import UIKit

final class ToDosDetailController: UIViewController {
    
    //MARK: - Outlets
    private lazy var taskName: UITextView = {
       let textView = UITextView()
        
        return textView
    }()
    
    private lazy var taskDescription: UITextView = {
       let textView = UITextView()
        
        return textView
    }()
    
    private lazy var dateLabel: UILabel = {
       let label = UILabel()
        
        return label
    }()
    
    //MARK: - Lifecycel
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
    }
    
    
    //MARK: - Setup Hierarhcy
    private func setupHierarchy() {
        
    }
    
    //MARK: - Setup Layout
    private func setupLayout() {
        
    }
    
    //MARK: - Setup Elements
    
}
