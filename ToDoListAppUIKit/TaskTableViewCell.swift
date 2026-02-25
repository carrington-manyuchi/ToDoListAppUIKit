//
//  TaskTableViewCell.swift
//  ToDoListAppUIKit
//
//  Created by Manyuchi, Carrington C on 2026/02/22.
//

import UIKit

protocol TaskTableViewCellView: AnyObject {
    func editTask(id: String)
    func markTask(id: String, complete: Bool)
}

class TaskTableViewCell: UITableViewCell {
    static let identifier = "TaskTableViewCell"
    @IBOutlet weak var categoryContainerView: UIView! {
        didSet {
            categoryContainerView.layer.cornerRadius = categoryContainerView.frame.height / 2
        }
    }
    
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.layer.cornerRadius = 8
            containerView.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var isCompleteImageView: UIImageView!
    
    
    private var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }
    
    private weak var taskTableViewCellView: TaskTableViewCellView?
    private var task: TaskModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(withTask task: TaskModel, taskTableViewCellView: TaskTableViewCellView?) {
        categoryLabel.text = task.category.rawValue
        captionLabel.text = task.caption
        isCompleteImageView.image = task.isComplete ? UIImage(systemName: "checkmark.circle") : UIImage(systemName: "circle")
        dateLabel.text = dateFormatter.string(from: task.createdDate)
        selectionStyle = .none
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(toggleCompletion))
        isCompleteImageView.addGestureRecognizer(tap)
        isCompleteImageView.isUserInteractionEnabled = true
        self.task = task
        self.taskTableViewCellView = taskTableViewCellView
    }
    
    @objc func toggleCompletion() {
        task?.isComplete.toggle()
        taskTableViewCellView?.markTask(id: task.id, complete: task.isComplete)
    }
    
    @IBAction func editTaskButtonTapped(_ sender: UIButton) {
    }
    
}
