//
//  ShowContentsViewController.swift
//  newProject
//
//  Created by 김수빈 on 07/08/2019.
//  Copyright © 2019 김수빈. All rights reserved.
//

import Foundation
import UIKit

// imageView와 Label로 이루어진 customcell을 갖고 있는 tableView
// cell identifier : ContentCustomCell(Custom cell 클래스명과 동일)
//


// tableview의 cell Label, imageView의 내용이 될 배열과
// cell 클릭 시 이동할 viewcontroller의 id 배열
let items = ["첫번째", "두번째"]
let images = ["image1.jpg", "image2.jpg"]
let viewControllerID = ["helloSwiftView", "calculatorView"]

class ShowContentsViewController : UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var contentTableView: UITableView!
    
    override func viewDidLoad() {
        contentTableView.delegate = self
        contentTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContentCustomCell", for: indexPath) as! ContentCustomCell
        
        cell.cellLabel.text = items[indexPath.row]
        cell.cellImageView.image = UIImage(named: images[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: viewControllerID[indexPath.row])
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
    }
}
