//
//  CalculatorViewControllerWithStack.swift
//  newProject
//
//  Created by 김수빈 on 12/08/2019.
//  Copyright © 2019 김수빈. All rights reserved.
//

import Foundation
import UIKit


class CalculatorViewControllerWithStack : UIViewController, sendDataProtocol {
    
    // ShowHistoryView에서 가져온 cell의 데이터를 처리하는 함수
    func sendDataToNewCalculatorView(data: String) {
        
        var tmp = data.split(separator: "=")
        
        showFormula.text = data
        showResult.text = "\(tmp[1])"
        
        result = Double(tmp[1])!
        currentNumber = showResult.text!
    }
    
    // 입력중인 값
    var currentNumber = ""
    // 계산할 값1을 저장
    var preValue = ""
    // 계산할 값2를 저장
    var newValue = ""
    // 연산을 수행할 사칙연산 기호
    var calculator : Operator = Operator.Nil
    // 계산 결과
    var result : Double = 0
    
    // 결과 보여주는 창
    @IBOutlet var showResult: UILabel!
    
    // 입력한 식을 보여주는 창
    @IBOutlet var showFormula: UILabel!
    
    // showFormula Label에 담을 식
    var formula : String = String()
    
    // Navigation bar의 오른쪽 History 버튼을 눌렀을 때 보여질 식 목록을 담는 배열
    var formulaArray : [String] = []
    
    // navigation button 선언
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
        
        print("currentValue : \(currentNumber)")
        
        
    }
    
    // navigation bar Right button - historyButton을 눌렀을 때 실행할 메서드.
    // history 버튼을 눌렀을 때 ShowHistoryView로 데이터를 전달
    @objc func rightAction(){
        
        self.navigationController?.pushViewController(ShowHistoryViewController.init(), animated: true)
        
        // CalculatorView -> ShowHistoryView 계산 식이 담긴 array 전달.
        performSegue(withIdentifier: "sendArray", sender: self)
    }
    
    // CalculatorView -> ShowHistoryView 계산 식이 담긴 array 전달
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sendFormula" {
            
            let destinationViewController = segue.destination as! NewFormulaTable
            destinationViewController.items = formulaArray
            
            // 프로토콜 채택 및 대리자 위임
            destinationViewController.delegate = self as? sendDataProtocol
            
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
            
            showFormula.text = formula
            
            currentNumber = showResult.text!
            
            formulaArray.append(formula)
            print(formulaArray)
            
            // 식, 계산 결과, 계산 식 배열을 userdefaults를 사용해 저장
            UserDefaults.standard.set(formula, forKey: "formula")
            UserDefaults.standard.set(result, forKey: "result")
            UserDefaults.standard.set(formulaArray, forKey : "array")
            
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
                
                currentNumber = "0"
                // 연속계산을 위해 계산할 값 1에 계산 결과를 저장하고 보여줌
                preValue = String(result)
                showResult.text = preValue
                
            }
            calculator = opt
        }
    }
}
