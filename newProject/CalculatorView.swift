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

enum Operator : String {
    case Equal = "="
    case Add = "+"
    case Substract = "-"
    case Multiply = "*"
    case Divide = "/"
    case Reverse = "+/-"
    case Percentage = "%"
    case Nil = "Nil"
}

class CalculatorView : UIViewController {
    
    // 상속 클래스를 명확히 해줄 것.
    // 코드 상으로 버튼 속성에 접근, 변경이 필요없으면 선언할 필요 없음!
    //@IBOutlet var number0: UIRoundButton!
    @IBOutlet var buttonDot: UIRoundButton!
    
    // 입력중인 값
    var currentNumber = ""
    // 계산할 값1을 저장
    var preValue = ""
    // 계산할 값2를 저장
    var newValue = ""
    // 연산을 수행할 사칙연산 기호
    var calculator : Operator = Operator.Nil
    // 계산 결과
    var result : Double = 0.0
    
    // 결과 보여주는 창
    @IBOutlet var showResult: UILabel!
    
    // 입력한 식을 보여주는 창
    @IBOutlet var showFormula: UILabel!
    // showFormula Label에 담을 식
    var formula : String = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func isClickNumber(button : UIRoundButton) {
        
        // button.title을 사용해 입력한 숫자를 보여주는 방식을 button.tag를 사용하여 변경
        
        // showResult에 입력된 문자열의 마지막이 "."이면 "." 버튼을 disabled 상태로 바꿔 소수점을 여러번 입력하는 것을 방지했던 것에서
        // 문자열의 contains 프로퍼티를 사용해 소수점이 포함되어 있지 않을 경우에만 소수점 추가
        
        if button.tag == 10 {
            if currentNumber.contains(".") == false {
                currentNumber += "."
            }
        } else {
            if currentNumber == "0" {
                // showResult의 문자열이 0일때 입력하는 숫자를 0대신 표시
                currentNumber = String(button.tag)
            } else {
                // showResult의 문자열이 0이 아닐 때에는 입력하는 숫자를 추가
                currentNumber += String(button.tag)
            }
        }
        
        showResult.text! = currentNumber
        

    }
    
    @IBAction func isOptClick(button : UIRoundButton) {
        let clickedOpt = button.tag
        /// AC, +/-, % : tag 11, 12, 13
        /// +, -, x, /, = : tag 14, 15, 16, 17, 18

        
//        연산자를 누를 때 showResult Label의 text를 saveValue에 저장
//        누른 연산자를 calculator에 저장
//        다음 새로운 값을 입력받기 위해 showResult Label과 newValue를 비워줌
        switch clickedOpt {
            
        case 11 :   // AC
            currentNumber = "0"
            showResult.text = currentNumber
            showFormula.text = ""
            calculator = .Nil
            preValue = ""
            newValue = ""
            result = 0
            formula = ""
            
        case 12 :   // +/- 버튼
            calculate(opt : .Reverse)
            
        case 13 :   // % 버튼
            calculate(opt : .Percentage)
            
        case 14 :   // + 버튼
            calculate(opt : .Add)
            
            
        case 15 :   // - 버튼
            calculate(opt : .Substract)
            
            
        case 16 :   // * 버튼
            calculate(opt : .Multiply)
            
            
        case 17 :   // / 버튼
            calculate(opt : .Divide)
            
            
        default:    // = 버튼
            calculate(opt : .Equal)
            formula.append("\(result)")
            showFormula.text! = formula
            formula = ""
            
        }
        
    }
    
    func calculate(opt : Operator) {
        
        formula.append(currentNumber)
        formula.append(opt.rawValue)
        
        
        if calculator == .Nil {
            // 연산기호가 입력되지 않은 경우 입력한 수가 계산할 값 1이 됨
            preValue = currentNumber
            currentNumber = "0"
            calculator = opt
        } else {
            if currentNumber != "0" {
                // 연산기호가 입력되었을 때 입력한 수는 계산할 값 2가 됨
                
                if calculator == .Percentage {
                    currentNumber = String(Double(currentNumber)! * 0.01)
                } else if calculator == .Reverse {
                    currentNumber = String(-Double(currentNumber)!)
                }
                
                newValue = currentNumber
                currentNumber = "0"
                
                // 연산기호에 따라 해당하는 연산을 하고 result에 저장
                if calculator == .Add {
                    result = Double(preValue)! + Double(newValue)!
                } else if calculator == .Substract {
                    result = Double(preValue)! - Double(newValue)!
                } else if calculator == .Multiply {
                    result = Double(preValue)! * Double(newValue)!
                } else if calculator == .Divide {
                    result = Double(preValue)! / Double(newValue)!
                }
                
                // 연속계산을 위해 계산할 값 1에 계산 결과를 저장하고 보여줌
                preValue = String(result)
                showResult.text = preValue
            
            }
            calculator = opt
        }
    }

    
}
