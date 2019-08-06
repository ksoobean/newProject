//
//  ShowHistoryView.swift
//  newProject
//
//  Created by 김수빈 on 02/08/2019.
//  Copyright © 2019 김수빈. All rights reserved.
//

import Foundation
import UIKit


class ShowHistoryView : UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var showHistoryTableView: UITableView!
    
    // table view의 cell을 구성할 항목
    var items : [String] = []
    
    override func viewDidLoad() {
        
        // tableView를 위한 delegate와 dataSource
        showHistoryTableView.delegate = self
        showHistoryTableView.dataSource = self
        
        self.showHistoryTableView.register(UITableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        self.view.addSubview(self.showHistoryTableView)
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell")! as UITableViewCell
        
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
}
