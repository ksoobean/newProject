//
//  ModalView.swift
//  newProject
//
//  Created by 김수빈 on 31/07/2019.
//  Copyright © 2019 김수빈. All rights reserved.
//
import UIKit

class ModalView: UIViewController {
    
    // dismiss 버튼을 누르면 모달 닫기
    @IBAction func dismiss(_ sender: Any) {
        
        // 모달 보이기 액션
//        self.present(<#T##viewControllerToPresent: UIViewController##UIViewController#>, animated: <#T##Bool#>, completion: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
        
        // 모달 닫기 액션
        self.dismiss(animated: true, completion: nil)
        
    }
}
