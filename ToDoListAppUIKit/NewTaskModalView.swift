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
            descriptionTextView.delegate = self
        }
    }
    
    @IBOutlet private weak var categoryPickerView: UIPickerView! {
        didSet {
            categoryPickerView.dataSource = self
            categoryPickerView.delegate = self
        }
    }
    
    @IBOutlet private weak var submitButton: UIButton! {
        didSet {
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryPickerView.selectRow(1, inComponent: 0, animated: false)
        layer.cornerRadius = 5
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
    }

    @IBAction func submitButtonTapped(_ sender: UIButton) {
    }
    
}

extension NewTaskModalView: UITextViewDelegate  {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text =  "Add caption..."
            textView.textColor = UIColor.lightGray
        }
    }
}

extension NewTaskModalView: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Category.allCases.count
    }
    
    
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return Category.allCases[row].rawValue
//    }
//    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = view as? UILabel
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = .systemFont(ofSize: 16, weight: .regular)
            pickerLabel?.textAlignment = .center
        }
        
        let category = Category.allCases[row]
        pickerLabel?.text = category.rawValue
        return pickerLabel!
    }
}


