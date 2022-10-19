//
//  ViewController.swift
//  ToDoList
//
//  Created by Daniil Akmatov on 17/10/22.
//

import UIKit

class ViewController: UIViewController {

    var todos = [
        ToDo(title: "Make vanilla pudding.", description: "Watch youtube video and follow guidance.", isComplete: false),
        ToDo(title: "Put pudding in a mayo jar.", description: "lore ipsume...", isComplete: false),
        ToDo(title: "Eat it in a public place.", description: "Mmm...", isComplete: false),
    ]
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func startEditing(_ sender: Any) {
        tableView.isEditing = !tableView.isEditing
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ViewController: CheckTableViewCellDelegate {
    
    func checkTableViewCell(_ cell: CheckTableViewCell, didChagneCheckedState checked: Bool) {
        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        let todo = todos[indexPath.row]
        let newTodo = ToDo(title: todo.title, description: todo.description, isComplete: todo.isComplete)
        
        todos[indexPath.row] = newTodo
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .normal, title: "Complete") { action, view, complete in
            print("complete")
        }
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "checked cell", for: indexPath) as! CheckTableViewCell
        
        cell.delegate = self
        
        let todo = todos[indexPath.row]
        
        cell.set(title: todo.title, checked: todo.isComplete)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let todo = todos.remove(at: sourceIndexPath.row)
        todos.insert(todo, at: destinationIndexPath.row)
    }
}
