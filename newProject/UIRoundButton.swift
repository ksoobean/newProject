//
//  UIRoundButton.swift
//  newProject
//
//  Created by 김수빈 on 02/08/2019.
//  Copyright © 2019 김수빈. All rights reserved.
//

import Foundation
import UIKit

/// UIButton 클래스를 상속하는 custom class UIRoundButton을 만들어서 버튼의 디자인을 한번에 입혀줌
class UIRoundButton : UIButton {
    required init(coder aDecoder : NSCoder) {
        super.init(coder : aDecoder)!
        
        // 태그를 custom class에서 한번에 만들어줄 수 있음(태그 : ui의 id 같은 것)
        
        if self.tag == 0 {
            // number0 버튼의 양쪽 끝을 둥글게 입혀줌
            self.layer.cornerRadius = self.frame.width/5
            self.layer.masksToBounds = true
        } else {
            // 정사각형의 버튼을 원으로 모양 변경 후 입혀줌
            self.layer.cornerRadius = self.frame.width/2.2
            self.layer.masksToBounds = true
        }
        
    }
    
}
