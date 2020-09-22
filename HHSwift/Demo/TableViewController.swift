//
//  TableViewController.swift
//  HHSwift
//
//  Created by hjn on 2020/1/7.
//  Copyright © 2020 huang. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    let _colors:[UIColor] = [UIColor.red,
                             UIColor.blue,
                             UIColor.orange,
                             UIColor.cyan,
                             UIColor.yellow,
                             UIColor.green,
                             UIColor.systemPink,
                             UIColor.lightGray]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let i:Int = Int.init(arc4random()%6)
        
        view.backgroundColor = _colors[i]
        tableView.tableFooterView = UIView()
    }
    
    
}
