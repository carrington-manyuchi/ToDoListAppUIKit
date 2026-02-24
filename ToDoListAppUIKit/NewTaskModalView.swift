//
//  NewTaskModalView.swift
//  ToDoListAppUIKit
//
//  Created by Manyuchi, Carrington C on 2026/02/22.
//

import UIKit

class NewTaskModalView: UIView {
    @IBOutlet var contentView: UIView!

    @IBOutlet private weak var descriptionTextView: UITextView! {
        didSet {
            descriptionTextView.layer.borderWidth = 0.5
            descriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
            descriptionTextView.layer.cornerRadius = 8
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
    
    weak var view: NewTaskView?
    private var task: TaskModel?
    
    var caption: String {
        get { return descriptionTextView.text }
        set { descriptionTextView.text = newValue }
    }
    
    init(frame: CGRect, task: TaskModel?) {
        super.init(frame: frame)
        self.task = task
        initSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initSubviews()
    }
    
    func initSubviews() {
        let nib = UINib(nibName: "NewTaskModalView", bundle: nil)
        nib.instantiate(withOwner: self)
        contentView.frame = bounds
        contentView.layer.cornerRadius = 5
        addSubview(contentView)
        
        if let task = task {
            descriptionTextView.text = task.caption
            descriptionTextView.textColor = .black
            if let rowIndex = Category.allCases.firstIndex(of: task.category) {
                categoryPickerView.selectRow(rowIndex, inComponent: 0, animated: false)
            }
        } else {
            descriptionTextView.text = "Add caption..."
            descriptionTextView.textColor = .lightGray
            categoryPickerView.selectRow(1, inComponent: 0, animated: false)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        view?.closeView()
    }

    @IBAction func submitButtonTapped(_ sender: UIButton) {
        
        guard let caption = descriptionTextView.text,
        caption.count >= 4 else {
                return
            }
        
        let selectedRow = categoryPickerView.selectedRow(inComponent: 0)
        let category = Category.allCases[selectedRow]
        
        if let task = task {
            let task = TaskModel(id: task.id, category: category, caption: caption, createdDate: task.createdDate, isComplete: task.isComplete)
            let userInfo: [String: TaskModel] = ["updateTask" : task]

            NotificationCenter.default.post(name: NSNotification.Name("com.fullstacktuts.editTask"), object: nil, userInfo: userInfo)

        } else {
            let taskId = UUID().uuidString
            let task = TaskModel(id: taskId, category: category, caption: caption, createdDate: Date(), isComplete: false)
            let userInfo: [String: TaskModel] = ["newTask" : task]
            NotificationCenter.default.post(name: NSNotification.Name("com.fullstacktuts.createTask"), object: nil, userInfo: userInfo)
        }        
        view?.closeView()
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


