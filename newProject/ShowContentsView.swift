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


class ShowContentsViewController : UIViewController {
    
    @IBOutlet weak var contentTableView: UITableView!
    
    // tableview의 cell Label, imageView의 내용이 될 배열과
    // cell 클릭 시 이동할 viewcontroller의 id 배열
    
    let content : [[String]] = [["첫번째", "image1.jpg", "helloSwiftView"], ["두번째", "image2.jpg", "calculatorView"], ["세번째", "image3.jpg", "calculatorWithStackView"], ["네번째", "image4.jpg", "webKitView"], ["다섯번째", "image5.jpg", "collectionView"], ["여섯번째", "image5.jpg", "swiftUIView"]]
    
    override func viewDidLoad() {
        contentTableView.delegate = self
        contentTableView.dataSource = self
    }
}
    
//MARK:- UITabelviewDelegate
extension ShowContentsViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: content[indexPath.row][2])
        
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
}

//MARK:- UITableViewDataSource
extension ShowContentsViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContentCustomCell", for: indexPath) as! CustomCell
        
        // dequeueReusableCell의 개념 추가로 공부해보기
        
        cell.cellLabel.text = content[indexPath.row][0]
        cell.cellImage.image = UIImage(named: content[indexPath.row][1])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }
}
    


