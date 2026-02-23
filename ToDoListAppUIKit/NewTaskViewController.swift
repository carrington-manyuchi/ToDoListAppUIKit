//
//  NewTaskViewController.swift
//  ToDoListAppUIKit
//
//  Created by Manyuchi, Carrington C on 2026/02/22.
//

import UIKit

class NewTaskViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .fullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.9)
    }


}
