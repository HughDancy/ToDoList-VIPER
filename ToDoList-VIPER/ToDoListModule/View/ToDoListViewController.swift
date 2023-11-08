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

        return button
    }()
    
    //MARK: - Lifecycle
    override func viewDidAppear(_ animated: Bool) {
        presenter?.viewWillAppear()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRightBarButton()
        view.backgroundColor = .yellow
        title = "Table"
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    //MARK: - Setup NavBar Button
    private func setupRightBarButton() {
        let menuBarItem = UIBarButtonItem(customView: addButton)
        self.navigationItem.rightBarButtonItem = menuBarItem
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    @objc func addToDo() {
        print("whoa")
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
