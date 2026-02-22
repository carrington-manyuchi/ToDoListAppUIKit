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
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}
