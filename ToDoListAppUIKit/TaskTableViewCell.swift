//
//  TaskTableViewCell.swift
//  ToDoListAppUIKit
//
//  Created by Manyuchi, Carrington C on 2026/02/22.
//

import UIKit

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

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
