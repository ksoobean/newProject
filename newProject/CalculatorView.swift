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

// 주석쓰기 최대한 자세하게..(단축키 : command + option  + /)
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
    // 코드 상으로 버튼 속성에 접근, 변경이 필요없으면 선언할 필요 없음!
    //@IBOutlet var number0: UIRoundButton!
    @IBOutlet var buttonPlus: UIRoundButton!
    
    var saveValue = "";
    var newValue = "";
    var calculator = "";
    var result : Double = 0.0
    
    // 결과 보여주는 창
    @IBOutlet var showResult: UILabel!
    @IBOutlet var showFormula: UILabel!
    var formula : String = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func isClickNumber(button : UIRoundButton) {
        
        // 숫자 버튼을 클릭할 때 showResult 라벨에 표시함.
        let clickednumber = (button.titleLabel!.text)!
        
        if showResult.text != "" {
            // 숫자가 입력중일 때
            showResult.text! += clickednumber
        } else {
            // 입력된 숫자가 없을 때
            showResult.text = clickednumber
        }
        
        // 저장된 값이 있을 때
        if saveValue != "" {
            // showResult 라벨의 숫자를 읽어서 newValue에 저장
            
            newValue = String(showResult.text!)
            
            // 계산을 위해 saveValue와 newValue의 값을 Double형으로 바꿈
            let tmp1 : Double = Double(saveValue)!
            let tmp2 : Double = Double(newValue)!
            
            // calculator에 해당하는 계산을 함수로 하고 결과를 result에 저장, showResult 라벨에 표시
            if calculator == "+" {
                formula.append(calculator)
                formula.append(newValue)
                result = plus(save : tmp1, new : tmp2)
                showResult.text = String(result)
            } else if calculator == "-" {
                formula.append(calculator)
                formula.append(newValue)
                result = minus(save : tmp1, new : tmp2)
                showResult.text = String(result)
            } else if calculator == "*" {
                formula.append(calculator)
                formula.append(newValue)
                result = multiply(save : tmp1, new : tmp2)
                showResult.text = String(result)
            } else if calculator == "/" {
                formula.append(calculator)
                formula.append(newValue)
                result = divide(save : tmp1, new : tmp2)
                showResult.text = String(result)
            }
        }
    }
    
    @IBAction func isOptClick(button : UIRoundButton) {
        let clickedOpt = button.tag
        /// AC, +/-, % : tag 11, 12, 13
        /// +, -, x, /, = : tag 14, 15, 16, 17, 18
        switch clickedOpt {
        case 11 :   // AC
            showResult.text = "0"
            calculator = ""
        case 12 :   // +/-
            let tmp : Double = -Double(String(showResult.text!))!
            saveValue = String(tmp)
            showResult.text = saveValue
            newValue = ""
        case 13 :   // %
            let tmp : Double = Double(String(showResult.text!))! * 0.01
            saveValue = String(tmp)
            showResult.text = saveValue
            newValue = ""
        case 14 :   // +
            saveValue = String(showResult.text!)
            calculator = "+"
            showResult.text = ""
            newValue = ""
        case 15 :   // -
            saveValue = String(showResult.text!)
            calculator = "-"
            showResult.text = ""
            newValue = ""
        case 16 :   // *
            saveValue = String(showResult.text!)
            calculator = "*"
            showResult.text = ""
            newValue = ""
        case 17 :   // /
            saveValue = String(showResult.text!)
            calculator = "/"
            showResult.text = ""
            newValue = ""
        default:    // =
            let tmp1 : Double = Double(saveValue)!
            let tmp2 : Double = Double(newValue)!
            if calculator == "+" {
                result = plus(save : tmp1, new : tmp2)
            } else if calculator == "-" {
                result = minus(save : tmp1, new : tmp2)
            } else if calculator == "*" {
                result = multiply(save : tmp1, new : tmp2)
            } else if calculator == "/" {
                result = divide(save : tmp1, new : tmp2)
            } else {
            }
            
            showResult.text = String(result)
            formula.append("= \(result)")
            showFormula.text = formula
            formula = ""
        }
        
    }
    
    func plus(save : Double, new : Double) -> Double {
        calculator = ""
        return save + new
    }
    
    func minus(save : Double, new : Double) -> Double {
        calculator = ""
        return save - new
    }
    
    func multiply(save : Double, new : Double) -> Double {
        calculator = ""
        return save * new
    }
    
    func divide(save : Double, new : Double) -> Double {
        calculator = ""
        return save / new
    }
}
