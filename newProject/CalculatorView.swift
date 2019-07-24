//
//  CalculatorView.swift
//  newProject
//
//  Created by 김수빈 on 23/07/2019.
//  Copyright © 2019 김수빈. All rights reserved.
//

import Foundation
import UIKit

// custom class로 원형 버튼 한번에 만들기
class UIRoundButton : UIButton {
    required init(coder aDecoder : NSCoder) {
        super.init(coder : aDecoder)!
        
        self.layer.cornerRadius = self.frame.width/2
        self.layer.masksToBounds = true
    }
}

class CalculatorView : UIViewController {

    @IBOutlet var number0: UIButton!
   
    @IBOutlet var number1: UIButton!
    @IBOutlet var number2: UIButton!
    @IBOutlet var number3: UIButton!
    @IBOutlet var number4: UIButton!
    @IBOutlet var number5: UIButton!
    @IBOutlet var number6: UIButton!
    @IBOutlet var number7: UIButton!
    @IBOutlet var number8: UIButton!
    @IBOutlet var number9: UIButton!
    @IBOutlet var clear: UIButton!
    @IBOutlet var reverse: UIButton!
    @IBOutlet var percent: UIButton!
    @IBOutlet var divide: UIButton!
    @IBOutlet var multiply: UIButton!
    @IBOutlet var minus: UIButton!
    @IBOutlet var plus: UIButton!
    @IBOutlet var equal: UIButton!
    @IBOutlet var dot: UIButton!
    
    @IBOutlet var showResult: UILabel!
    
    var save : Double = 0   // 중간 계산 결과
    var input_operator : String = ""    // 연산자 입력
    var result : Double = 0 // 최종 출력할 결과
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        number0.layer.cornerRadius = number0.frame.width/4
        number0.layer.masksToBounds = true
    }
    
    // 클릭한 버튼의 text를 읽고 showResult Label에 보여줌
    var isClickNumber = false
    @IBAction func isClickNumber(button : UIButton) {
        // var clickednumber was never mutated sol) var -> let)
        let clickednumber = button.titleLabel?.text
        if isClickNumber {
            showResult.text = showResult.text! + clickednumber!
        } else {
            showResult.text = clickednumber!
            isClickNumber = true
        }
    }
    
    var plusClick : Bool = false
    var minClick : Bool = false
    var mulClick : Bool = false
    var divClick : Bool = false
    
    @IBAction func calculate(button : UIButton) {
        let clickedOperator = button.titleLabel?.text
        
        switch clickedOperator {
            
        case "+" :
            print("do plus")
            save = Double(String(showResult.text!))!
            isClickNumber = false
            plusClick = true
            
        case "-" :
            print("do minus")
            save = Double(String(showResult.text!))!
            isClickNumber = false
            minClick = true
            
        case "x" :
            print("do multiply")
            save = Double(String(showResult.text!))!
            isClickNumber = false
            mulClick = true
            
        case "/" :
            print("do division")
            save = Double(String(showResult.text!))!
            isClickNumber = false
            divClick = true
            
        case "%" :
            print("make percentage")
            save = Double(String(showResult.text!))!
            showResult.text = String(save / 100)
            
        case "+/-" :
            print("make reverse")
            save = Double(String(showResult.text!))!
            showResult.text = String(-save)
            
        case "=" :
            print("default")
            showValue()
            
        default :   // "AC"
            print("clear all")
            save = 0
            result = 0
            showResult.text = ""
        }
    }
    
    func showValue() {
        print("show final value on label")
        
        let lastValue : Double = Double(String(showResult.text!))!
        
        if plusClick == true {
            result = save + lastValue
            showResult.text = "\(result)"
            plusClick = false
        }
        if minClick == true {
            result = save - lastValue
            showResult.text = "\(result)"
            minClick = false
        }
        if mulClick == true {
            result = save * lastValue
            showResult.text = "\(result)"
            mulClick = false
        }
        if divClick == true {
            if lastValue != 0 {
                result = save / lastValue
                showResult.text = "\(result)"
            } else {
                showResult.text = "오류"
            }
            divClick = false
        }
        
        print("result : \(result)")
    }
    
    
    
}
