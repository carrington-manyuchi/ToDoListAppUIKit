//
//  NewTaskModalView.swift
//  ToDoListAppUIKit
//
//  Created by Manyuchi, Carrington C on 2026/02/22.
//

import UIKit

class NewTaskModalView: UIView {

    @IBOutlet private weak var descriptionTextView: UITextView! {
        didSet {
            descriptionTextView.layer.borderWidth = 0.5
            descriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
            descriptionTextView.layer.cornerRadius = 8
            descriptionTextView.text = "Add caption..."
            descriptionTextView.textColor = .lightGray
        }
    }
    
    @IBOutlet private weak var categoryPickerView: UIPickerView! {
        didSet {
            
        }
    }
    
    @IBOutlet private weak var submitButton: UIButton! {
        didSet {
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
    }

    @IBAction func submitButtonTapped(_ sender: UIButton) {
    }
    
}
