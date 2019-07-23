//
//  CalculatorView.swift
//  newProject
//
//  Created by 김수빈 on 23/07/2019.
//  Copyright © 2019 김수빈. All rights reserved.
//

import Foundation
import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        number0.layer.cornerRadius = number0.frame.width/4
        number0.layer.masksToBounds = true
        number1.layer.cornerRadius = number1.frame.width/2
        number1.layer.masksToBounds = true
        number2.layer.cornerRadius = number2.frame.width/2
        number2.layer.masksToBounds = true
        number3.layer.cornerRadius = number3.frame.width/2
        number3.layer.masksToBounds = true
        number4.layer.cornerRadius = number4.frame.width/2
        number4.layer.masksToBounds = true
        number5.layer.cornerRadius = number5.frame.width/2
        number5.layer.masksToBounds = true
        number6.layer.cornerRadius = number6.frame.width/2
        number6.layer.masksToBounds = true
        number7.layer.cornerRadius = number7.frame.width/2
        number7.layer.masksToBounds = true
        number8.layer.cornerRadius = number8.frame.width/2
        number8.layer.masksToBounds = true
        number9.layer.cornerRadius = number9.frame.width/2
        number9.layer.masksToBounds = true
        clear.layer.cornerRadius = clear.frame.width/2
        clear.layer.masksToBounds = true
        reverse.layer.cornerRadius = reverse.frame.width/2
        reverse.layer.masksToBounds = true
        percent.layer.cornerRadius = percent.frame.width/2
        percent.layer.masksToBounds = true
        divide.layer.cornerRadius = divide.frame.width/2
        divide.layer.masksToBounds = true
        multiply.layer.cornerRadius = multiply.frame.width/2
        multiply.layer.masksToBounds = true
        minus.layer.cornerRadius = minus.frame.width/2
        minus.layer.masksToBounds = true
        plus.layer.cornerRadius = plus.frame.width/2
        plus.layer.masksToBounds = true
        equal.layer.cornerRadius = equal.frame.width/2
        equal.layer.masksToBounds = true
        dot.layer.cornerRadius = dot.frame.width/2
        dot.layer.masksToBounds = true
    }
    
    var save : Double = 0   // 계산 임시 저장
    var input_operator : String = ""    // 연산자 입력
    var result : Double = 0 // 최종 출력할 결과
    
    @IBOutlet var showResult: UILabel!
    
    var isClickNumber = false
    
    // 클릭한 버튼의 text를 showResult Label에 실시간으로 보여줌
    @IBAction func isClickNumber(button : UIButton) {
        var clickednumber = button.titleLabel?.text
        if isClickNumber {
            showResult.text = showResult.text! + clickednumber!
        } else {
            showResult.text = clickednumber!
            isClickNumber = true
        }
    }
    
    @IBAction func button_Clear(_ sender: Any) {
        print("clear all")
        save = 0
        result = 0
        showResult.text = ""
    }
    
    @IBAction func button_Result(_ sender: Any) {
        print("show result")
        if plusClick == true {
            result = save + Double(String(showResult.text!))!
            showResult.text = "\(result)"
            plusClick = false
        }
        if minClick == true {
            result = save - Double(String(showResult.text!))!
            showResult.text = "\(result)"
            minClick = false
        }
        if mulClick == true {
            result = save * Double(String(showResult.text!))!
            showResult.text = "\(result)"
            mulClick = false
        }
        if divClick == true {
            result = save / Double(String(showResult.text!))!
            showResult.text = "\(result)"
            divClick = false
        }
        
        print("result : \(result)")
    }
    
    var plusClick : Bool = false
    @IBAction func button_Plus(_ sender: Any) {
        print("do plus")
        save = Double(String(showResult.text!))!
        isClickNumber = false
        plusClick = true
    }
    
    var divClick : Bool = false
    @IBAction func button_Div(_ sender: Any) {
        print("do division")
        save = Double(String(showResult.text!))!
        isClickNumber = false
        divClick = true
    }
    
    var mulClick : Bool = false
    @IBAction func button_Mul(_ sender: Any) {
        print("do multiply")
        save = Double(String(showResult.text!))!
        isClickNumber = false
        mulClick = true
    }
    
    var minClick : Bool = false
    @IBAction func button_Min(_ sender: Any) {
        print("do minus")
        save = Double(String(showResult.text!))!
        isClickNumber = false
        minClick = true
    }
    
    @IBAction func button_Reverse(_ sender: Any) {
        print("make reverse")
        let temp : Double = Double(String(showResult.text!))!
        showResult.text = String(-temp)
        print("reverse result : \(String(describing: showResult.text))")
    }
    
    @IBAction func button_Percentage(_ sender: Any) {
        print("make percentage")
        let temp : Double = Double(String(showResult.text!))!
        showResult.text = String(temp / 100)
        print("percentage : \(result)")
    }
    
}
