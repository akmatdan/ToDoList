//
//  CheckTableViewCell.swift
//  ToDoList
//
//  Created by Daniil Akmatov on 17/10/22.
//

import UIKit

class CheckTableViewCell: UITableViewCell {

    @IBOutlet weak var checkBox: CheckBox!
    @IBOutlet weak var label: UILabel!
    
    @IBAction func checked(_ sender: CheckBox) {
        
    }
    
    func set(title: String, checked: Bool) {
        label.text = title
        checkBox.checked = checked
        updateChecked()
    }
    
    private func updateChecked() {
        let atributedString = NSMutableAttributedString(string: label.text!)
        
        if checkBox.checked {
            atributedString.addAttribute(.strikethroughStyle, value: 2, range: NSMakeRange(0, atributedString.length-1))
        } else {
            atributedString.removeAttribute(.strikethroughStyle, range: NSMakeRange(0, atributedString.length-1))
        }
        
        label.attributedText = atributedString
    }
    
}
