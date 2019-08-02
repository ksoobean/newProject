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
 UserDefaults
 
    UserDefaults : 사용자의 기본 설정과 같으 단일 데이터 값의 저장에 적합!
    [데이터, 키]의 형식으로 저장
    키의 형식은 String(문자열)
    데이터로 저장할 수 있는 형식은 아무거나 가능!
  UserDefaults 지정 방법
    - UserDefaults.standard.set(formula, forKey: "formula")
    - UserDefaults.standard.set(result, forKey: "result")
    - UserDefaults.standard.set(formulaArray, forKey : "array")
 
  UserDefaults 가져오기
    - UserDefaults.standard.string(forKey: "formula")
 
 */

/*
 ViewController 간의 데이터 전달
 1. storyboard에서 버튼 액션의 identifier 정의
 
 2. 단방향 / 양방향에 따라 적합한 방식으로 코드 구현
 - 단방향 : performSegue(withIdentifier: , sender:) & override func prepare(for segue: UIStoryboardSegue, sender: Any?){} 로 전달
 - 양방향 : delegate를 사용해 전달
 
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
    
    // Navigation bar의 오른쪽 History 버튼을 눌렀을 때 보여질 식 목록을 담는 배열
    var formulaArray : [String] = []
    
    // 식 목록을 표시하기 위한 Navigation Right Bar Button
    @IBOutlet var historyButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UserDefaults로 저장한 식과 값을 Key로 식별해서 가져옴
        showFormula.text! = UserDefaults.standard.string(forKey: "formula") ?? ""
        showResult.text! = UserDefaults.standard.string(forKey: "result") ?? "0"
        
        formulaArray.append((UserDefaults.standard.string(forKey: "array")) ?? showFormula.text!)
        
        // 마지막 결과로 연산을 이어가기 위해서 추가.
        currentNumber = showResult.text!
        
        // historyButton을 만들고 액션 메서드 등 정의
        let historyButton = UIButton()
        historyButton.addTarget(self, action: #selector(rightAction), for: .touchUpInside)
        
        self.navigationItem.rightBarButtonItem = self.historyButton
        
        print(formulaArray)
        
       
    }
    
    // navigation bar Right button - historyButton을 눌렀을 때 실행할 메서드.
    @objc func rightAction(){
        self.navigationController?.pushViewController(ShowHistoryView.init(), animated: true)
        
        // 단방향 데이터 전달. CalculatorView -> ShowHistoryView
        performSegue(withIdentifier: "sendArray", sender: self)
        
    }
    
    // 단방향 데이터 전달 시 필요한 함수
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sendArray" {
            
            let destinationViewController = segue.destination as! ShowHistoryView
            destinationViewController.items = formulaArray
            
        }
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
            
            currentNumber = showResult.text!
            
            formulaArray.append(formula)
            print(formulaArray)
            
            // 식, 계산 결과, 계산 식 배열을 userdefaults를 사용해 저장
            UserDefaults.standard.set(formula, forKey: "formula")
            UserDefaults.standard.set(result, forKey: "result")
            UserDefaults.standard.set(formulaArray, forKey : "array")
            
            showFormula.text! = formula
            formula = ""
            
        }
        
    }

    /// 입력된 연산기호에 맞는 사칙연산을 수행하거나 결과를 보여주는 함수
    ///
    /// - Parameter opt: 버튼으로 입력한 연산기호
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
                
                currentNumber = "0"
                // 연속계산을 위해 계산할 값 1에 계산 결과를 저장하고 보여줌
                preValue = String(result)
                showResult.text = preValue
            
            }
            calculator = opt
        }
    }

    
}
