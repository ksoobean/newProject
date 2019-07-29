//
//  CalculatorView.swift
//  newProject
//
//  Created by 김수빈 on 23/07/2019.
//  Copyright © 2019 김수빈. All rights reserved.
//

/// number0 ~ number9, dot : tag 0 ~ 10
/// AC, +/-, % : tag 11, 12, 13
/// +, -, x, /, = : tag 14, 15, 16, 17, 18

// 주석쓰기 최대한 자세하게.. 제발... (단축키 : command + option  + /)
// 입력했던 값 결과창 위에다 표시 추가.
// 모달. 1번에서 두번째 화면에 back 버튼 지우고 모달뷰 추가.

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
            self.layer.cornerRadius = self.frame.width/2
            self.layer.masksToBounds = true
        }
        
    }
    
}

class CalculatorView : UIViewController {

    // 상속 클래스를 명확히 해줄 것.
    @IBOutlet var number0: UIRoundButton!
    @IBOutlet var number1: UIRoundButton!
    @IBOutlet var number2: UIRoundButton!
    @IBOutlet var number3: UIRoundButton!
    @IBOutlet var number4: UIRoundButton!
    @IBOutlet var number5: UIRoundButton!
    @IBOutlet var number6: UIRoundButton!
    @IBOutlet var number7: UIRoundButton!
    @IBOutlet var number8: UIRoundButton!
    @IBOutlet var number9: UIRoundButton!
    @IBOutlet var dot: UIRoundButton!
    @IBOutlet var clear: UIRoundButton!
    @IBOutlet var reverse: UIRoundButton!
    @IBOutlet var percent: UIRoundButton!
    @IBOutlet var divide: UIRoundButton!
    @IBOutlet var multiply: UIRoundButton!
    @IBOutlet var minus: UIRoundButton!
    @IBOutlet var plus: UIRoundButton!
    @IBOutlet var equal: UIRoundButton!
    
    // 결과 보여주는 창
    @IBOutlet var showResult: UILabel!
    // 계산 결과
    var result : String = String()
    
    
    // 최종 결과 표시 이전에 입력한 식(formula)
    @IBOutlet var showFormula: UILabel!
    // 숫자, 연산 기호를 배열에 차례로 담음
    var formula: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // 입력한 숫자
    var currentNumber : Double = Double()
    
    // 클릭한 버튼의 text를 읽고 showResult Label에 보여줌
    var isNumberClicked = false
    @IBAction func isClickNumber(button : UIButton) {
        // var clickednumber was never mutated sol) var -> let)
        let clickednumber = button.titleLabel?.text
        if isNumberClicked {
            showResult.text! = showResult.text! + clickednumber!
        } else {
            // 숫자를 처음 클릭했을 때
            showResult.text! = clickednumber!
            isNumberClicked = true
        }
    }
    
    
    // 숫자, dot을 제외한 버튼들이 선택됐을 때
    /// AC, +/-, % : tag 11, 12, 13
    /// +, -, x, /, = : tag 14, 15, 16, 17, 18
    
    var priority : Int = 0
    @IBAction func clickedOperator(_ sender: UIRoundButton) {
        
        formula.append(showResult.text!)
        
        // 새로운 수를 입력받기 위함
        isNumberClicked = false
        
        switch sender.tag {
            
        case 11 : //"AC"
            showResult.text = "0"
            formula.removeAll()
            showFormula.text = ""
            
        case 14 : //"+"
            formula.append("+")
        case 15 : //"-"
            formula.append("-")
        case 16 : //"*"
            formula.append("*")
        case 17 : //"/"
            formula.append("/")
            
        default : //"="
            showFormula.text = formula.joined()
            calculate(formula : formula)
            showResult.text = result
        }
    }

    func calculate(formula : [String]) -> String{
        
        for i in 0...(formula.count - 1) {
            
        }
        return result
    }
}
