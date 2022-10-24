//
//  TodoViewController.swift
//  ToDoList
//
//  Created by Daniil Akmatov on 19/10/22.
//

import UIKit

protocol TodoViewControllerDelegate: AnyObject {
    func todoViewController(_ vc: TodoViewController, didSaveToDo: Todo)
}

class TodoViewController: UIViewController {
    
    @IBOutlet weak var textFieldTitle: UITextField!
    @IBOutlet weak var textFieldDescription: UITextField!
    
    var todo: Todo?
    
    weak var delegate: TodoViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textFieldTitle.text = todo?.title
        textFieldDescription.text = todo?.description
    }

    @IBAction func save(_ sender: Any) {
        if textFieldTitle.text!.isEmpty || textFieldDescription.text!.isEmpty {
            // 
        }
        let todo = Todo(title: textFieldTitle.text!, description: textFieldDescription.text!)
        delegate?.todoViewController(self, didSaveToDo: todo)
    }
}

