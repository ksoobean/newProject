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


/*
 개선해야할 사항.
    - 연산자 입력 후 다음 숫자 입력 시 한자리만 입력이 되는 것
    - 소수점 -> "." 버튼을 disabled로 전환.
    - 연산자를 연속적으로 눌렀을 때
 */

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
    @IBOutlet var buttonDot: UIRoundButton!
    
    
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
        
        // showResult label에 0이 입력되어 있을 때 0 삭제
        if showResult.text == "0" {
            showResult.text = ""
        }
        
        showResult.text! += clickednumber
        
        // 숫자를 입력 중 showResult의 text 가장 마지막이 "."이면 "." 버튼 클릭 disabled 상태로 변경
        if String(showResult.text!).last == "." {
            buttonDot.isUserInteractionEnabled = false
        } else {
            buttonDot.isUserInteractionEnabled = true
        }

    }
    
    @IBAction func isOptClick(button : UIRoundButton) {
        let clickedOpt = button.tag
        /// AC, +/-, % : tag 11, 12, 13
        /// +, -, x, /, = : tag 14, 15, 16, 17, 18

        if saveValue.isEmpty {
            var firstValue : String = "";
            firstValue = String(showResult.text!)
            saveValue = firstValue
        }
        
//        연산자를 누를 때 showResult Label의 text를 saveValue에 저장
//        누른 연산자를 calculator에 저장
//        다음 새로운 값을 입력받기 위해 showResult Label과 newValue를 비워줌
        switch clickedOpt {
            
        case 11 :   // AC
            showResult.text = "0"
            showFormula.text = ""
            calculator = ""
            saveValue = ""
            newValue = ""
            formula = ""
            
        case 12 :   // +/- 버튼
            let tmp : Double = Double(showResult.text!) ?? 0
            saveValue = String(-tmp)
            showResult.text = saveValue
            newValue = ""
            
        case 13 :   // % 버튼
            let tmp : Double = Double(showResult.text!) ?? 0
            saveValue = String(tmp * 0.01)
            showResult.text = saveValue
            newValue = ""
            
        case 14 :   // + 버튼
            let tmp1 : Double = Double(saveValue) ?? 0
            let tmp2 : Double = Double(showResult.text!) ??  0
            
            saveValue = calculate(save: tmp1, new: tmp2)
            
            calculator = "+"
            
            if formula.last == "+" || formula.last == "-" || formula.last == "*" || formula.last == "/" {
            } else {
                formula.append(calculator)
            }
            
            showResult.text = ""
            newValue = ""
            
            
        case 15 :   // - 버튼
            let tmp1 : Double = Double(saveValue) ?? 0
            let tmp2 : Double = Double(showResult.text!) ?? 0
            
            saveValue = calculate(save: tmp1, new: tmp2)
            
            calculator = "-"
            
            if formula.last == "+" || formula.last == "-" || formula.last == "*" || formula.last == "/" {
            } else {
                formula.append(calculator)
            }
            
            showResult.text = ""
            newValue = ""
            
        case 16 :   // * 버튼
            let tmp1 : Double = Double(saveValue) ?? 0
            let tmp2 : Double = Double(showResult.text!) ?? 0
            
            saveValue = calculate(save: tmp1, new: tmp2)
            
            calculator = "*"
            
            if formula.last == "+" || formula.last == "-" || formula.last == "*" || formula.last == "/" {
            } else {
                formula.append(calculator)
            }
            
            showResult.text = ""
            newValue = ""
        case 17 :   // / 버튼
            let tmp1 : Double = Double(saveValue) ?? 0
            let tmp2 : Double = Double(showResult.text!) ?? 0
            
            saveValue = calculate(save: tmp1, new: tmp2)
            
            calculator = "/"
            
            if formula.last == "+" || formula.last == "-" || formula.last == "*" || formula.last == "/" {
            } else {
                formula.append(calculator)
            }
            
            showResult.text = ""
            newValue = ""
            
        default:    // = 버튼
            let tmp1 : Double = Double(saveValue) ?? 0
            let tmp2 : Double = Double(showResult.text!) ?? 0
            
            saveValue = calculate(save: tmp1, new: tmp2)
            
            showResult.text = String(saveValue)
            formula.append("= \(saveValue)")
            showFormula.text = formula
            formula = ""
            saveValue = ""
            calculator = ""
            
        }
        
    }
    
    func calculate(save : Double, new : Double) -> String {
        
        formula += showResult.text!
        
        if calculator == "+" {
            saveValue = "\(save + new)"
        } else if calculator == "-" {
            saveValue = "\(save - new)"
        } else if calculator == "*" {
            saveValue = "\(save * new)"
        } else if calculator == "/" {
            if new != 0 {
                saveValue = "\(save / new)"
            } else {
                saveValue = "오류"
            }
        } else {
            saveValue = showResult.text!
        }
        
        return saveValue
    }
    
}
