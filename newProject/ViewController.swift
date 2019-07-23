//
//  ViewController.swift
//  newProject
//
//  Created by 김수빈 on 15/07/2019.
//  Copyright © 2019 김수빈. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // 아울렛 변수 : @IBOutlet으로 정의된 프로퍼티
    @IBOutlet var uiLabel: UILabel!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("viewDidLoad")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear")
    }

    override func viewDidDisappear(_ animated: Bool) {
        print("viewDidDisappear")
    }
    
    // 액션 메소드 : 객체의 이벤트를 제어할 때 사용하는 어노테이션과 함께 사용되는 메소드
    @IBAction func buttonSayHello(_ sender: Any) {
        self.uiLabel.text = "Hello Swift"
    }
    
    

}

