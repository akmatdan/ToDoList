//
//  TodoViewController.swift
//  ToDoList
//
//  Created by Daniil Akmatov on 19/10/22.
//

import UIKit

class TodoViewController: UIViewController {

    @IBOutlet weak var textfield: UITextField!
    
    var todo: ToDo?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textfield.text = todo?.title
    }

    @IBAction func save(_ sender: Any) {
    }
}
