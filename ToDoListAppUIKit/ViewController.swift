//
//  ViewController.swift
//  ToDoListAppUIKit
//
//  Created by Manyuchi, Carrington C on 2026/02/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var titleView: UIView! {
        didSet {
            titleView.clipsToBounds = true
            titleView.layer.cornerRadius = 24
            titleView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }
    }
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.estimatedRowHeight = 80
            tableView.rowHeight = UITableView.automaticDimension
        }
    }
    
    private var addButton:  UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.link
        button.tintColor = .white
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.imageView?.layer.transform = CATransform3DMakeScale(1.4, 1.4, 1.4)
        return button
    }()
    
    var tasks: [TaskModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(addButton)
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        tableView.separatorStyle = .none
        NotificationCenter.default.addObserver(self, selector: #selector(createTask(_:)), name: NSNotification.Name("com.fullstacktuts.createTask"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(editTask(_:)), name: NSNotification.Name("com.fullstacktuts.editTask"), object: nil)
    }
    
    @objc func createTask(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let task = userInfo["newTask"] as? TaskModel else {
            return
        }
        tasks.append(task)
        tableView.reloadData()
    }
    
    @objc func editTask(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let tasktoUpdate = userInfo["updateTask"] as? TaskModel else {
            return
        }
        
        let taskIndex = tasks.firstIndex { $0.id == tasktoUpdate.id }
        guard let taskIndex = taskIndex else {
            return
        }
        
        tasks[taskIndex] = tasktoUpdate
        tableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let safeAreabutton = view.safeAreaInsets.bottom
        let width: CGFloat = 60
        let height: CGFloat = 60
        let xPos  = (view.frame.width / 2) - (width / 2)
        let yPos = view.frame.height - height - safeAreabutton
        addButton.frame = CGRect(x: xPos, y: yPos, width: width, height: height)
        addButton.layer.cornerRadius = width / 2
    }
    
    @objc func addButtonTapped() {
        let newTaskViewController = NewTaskViewController()
        present(newTaskViewController, animated: true)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let task = tasks[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier, for: indexPath) as? TaskTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(withTask: task, taskTableViewCellView: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}


extension ViewController: TaskTableViewCellView {
    func editTask(id: String) {
        let taskIndex = tasks.firstIndex { $0.id == id }
        guard let taskIndex = taskIndex else {
            return
        }
        let newTaskViewController = NewTaskViewController(task: tasks[taskIndex])
        present(newTaskViewController, animated: true)
        tableView.reloadData()
    }
    
    func markTask(id: String, complete: Bool) {
        let taskIndex = tasks.firstIndex { $0.id == id }
        
        guard let taskIndex = taskIndex else {
            return
        }
        
        tasks[taskIndex].isComplete = complete
        tableView.reloadData()
    }
    
    
}
