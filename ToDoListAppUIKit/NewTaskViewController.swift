//
//  NewTaskViewController.swift
//  ToDoListAppUIKit
//
//  Created by Manyuchi, Carrington C on 2026/02/22.
//

import UIKit

protocol NewTaskView: AnyObject {
    func closeView()
}

class NewTaskViewController: UIViewController {
    lazy var modalView: NewTaskModalView = {
        let modalWidth = view.frame.width - CGFloat(30)
        let modalHeight: CGFloat = 430
        let frame = CGRect(x: 15, y: view.center.y - (modalHeight/2), width: modalWidth, height: modalHeight)
        let modalView = NewTaskModalView(frame: frame, task: task)
        modalView.view = self
        return modalView
    }()
    
    var task: TaskModel?
    
    init(task: TaskModel? = nil) {
        super.init(nibName: nil, bundle: nil)
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .fullScreen
        self.task = task
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.9)
        view.addSubview(modalView)
    }
}

//MARK: - Conformance to New Task
extension NewTaskViewController:  NewTaskView  {
    func closeView() {
        dismiss(animated: true)
    }
}
