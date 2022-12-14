//
//  ToDo.swift
//  ToDoList
//
//  Created by Daniil Akmatov on 17/10/22.
//

import Foundation

struct Todo {
    let title: String
    let description: String
    let isComplete: Bool
    
    init(title: String, description: String, isComplete: Bool = false) {
        self.title = title
        self.description = description
        self.isComplete = isComplete
    }
    
    func completeToggle() -> Todo{
        return Todo(title: title, description: description, isComplete: !isComplete)
    }
}
