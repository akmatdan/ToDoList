//
//  ViewController.swift
//  ToDoList
//
//  Created by Daniil Akmatov on 17/10/22.
//

import UIKit

class ViewController: UIViewController {

    let todos = [
        ToDo(title: "Make vanilla pudding.", discription: "Watch youtube video and follow guidance."),
        ToDo(title: "Put pudding in a mayo jar.", discription: "lore ipsume..."),
        ToDo(title: "Eat it in a public place.", discription: "Mmm..."),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "checked cell", for: indexPath) as! CheckTableViewCell
        
        let todo = todos[indexPath.row]
        
        cell.set(title: todo.title, checked: todo.isComplete)
        
        return cell
    }
}
