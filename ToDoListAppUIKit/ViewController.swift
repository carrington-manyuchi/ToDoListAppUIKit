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
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        floatingAddButton()
    }
    
    func floatingAddButton() {
        view.addSubview(addButton)
        let width: CGFloat = 60
        let height: CGFloat = 60
        let xPos  = (view.frame.width / 2) - (width / 2)
        let yPos = (view.frame.height - height)
        addButton.frame = CGRect(x: xPos, y: yPos, width: width, height: height)
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier, for: indexPath) as? TaskTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
    
    
}
