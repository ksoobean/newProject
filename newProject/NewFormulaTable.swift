//
//  NewFormulaTable.swift
//  newProject
//
//  Created by 김수빈 on 12/08/2019.
//  Copyright © 2019 김수빈. All rights reserved.
//

import Foundation
import UIKit

// 프로토콜과 프로토콜 함수 정의
// 프로토콜 함수는 프로토콜에서 정의만 해주고 구현은 해주지 않는다.
protocol sendDataProtocol {
    func sendDataToNewCalculatorView(data : String)
}

class NewFormulaTable : UIViewController {
    
    // 프로토콜타입의 변수 생성
    var delegate : sendDataProtocol? = nil
    
    @IBOutlet var formulaTable: UITableView!
    
    // table view의 cell을 구성할 항목
    var items : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        formulaTable.delegate = self
        formulaTable.dataSource = self
        
        // MyTableViewCell과 연결
        self.formulaTable.register(MyTableViewCell.self, forCellReuseIdentifier: "formulaCell")
        
//        // cell 높이를 cell 안의 데이터에 맞게 유동적으로 변경하는 방법
//        formulaTable.estimatedRowHeight = UITableView.automaticDimension
//        formulaTable.rowHeight = UITableView.automaticDimension
        
    }
}

extension NewFormulaTable : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "formulaCell", for: indexPath)
        
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    // cell 클릭 시 선택된 cell의 data를 이전 화면(calculatorView)으로 delegate를 사용해 전달
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dataToSend : String = items[indexPath.row]
        //print("clicked : \(items[indexPath.row])")
        
        self.delegate?.sendDataToNewCalculatorView(data: dataToSend)
        
        self.navigationController?.popViewController(animated: true)
    }
}
