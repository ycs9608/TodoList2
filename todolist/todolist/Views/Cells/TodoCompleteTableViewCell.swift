//
//  TodoCompleteTableViewCell.swift
//  todolist
//
//  Created by t2023-m0047 on 2024/01/11.
//

import UIKit

class TodoCompleteTableViewCell: UITableViewCell {
    
    var task: Task?
    
    func setTask(_ _task: Task) {
        task = _task
        guard let task else { return }
        textLabel?.text = task.title
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
