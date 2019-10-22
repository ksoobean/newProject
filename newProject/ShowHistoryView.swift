//
//  ShowHistoryView.swift
//  newProject
//
//  Created by 김수빈 on 02/08/2019.
//  Copyright © 2019 김수빈. All rights reserved.
//

import Foundation
import UIKit

// 2019.08.06 화요일 할일
//  1. ViewController 양방향 데이터 전달 delegate로 구현.
//      ShowHistoryView의 cell 선택 시 cell의 식을 CalculateView로 보내서 formula, result 표시
//  2. 만든 것 목차 페이지를 TableView로 만들어보기 Custom Cell 사용해서 이미지 등도 넣어보기
//
//       2019.08.07 수요일 Fin.

// 프로토콜과 프로토콜 함수 정의
// 프로토콜 함수는 프로토콜에서 정의만 해주고 구현은 해주지 않는다.
protocol sendClickedDataProtocol {
    func sendDataToCalculatorView(data : String)
}

// UITableViewDelegate, UITableViewDataSource 프로토콜을 채택.
class ShowHistoryViewController : UIViewController {
    
    // 프로토콜타입의 변수 생성
    var delegate : sendClickedDataProtocol? = nil
    
    @IBOutlet var showHistoryTableView: UITableView!
    
    // table view의 cell을 구성할 항목
    var items : [String] = []
    
    override func viewDidLoad() {
        
        // 프로토콜을 준수하면서 작업을 대신할 대리자를 지정함
        showHistoryTableView.delegate = self
        showHistoryTableView.dataSource = self
        
        
        // dequeueReusableCell 사용 전에 반드시 호출되어야 함.
        // cell에 identifier를 지정 - 방법 1
        // 또는 스토리보드에서 프로토타입 셀을 연결하고 identifier를 직접 지정 - 방법 2
        self.showHistoryTableView.register(UITableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        //self.view.addSubview(self.showHistoryTableView)
        
    }
 
}

//MARK:- UITabelviewDelegate, UITableViewDataSource
extension ShowHistoryViewController : UITableViewDelegate, UITableViewDataSource{
    
    // 프로토콜 채택 시 반드시 같이 선언해주어야 하는 함수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    // 프로토콜 채택 시 반드시 같이 선언해주어야 하는 함수
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // cell에 지정한 identifier를 dequeueReusableCell의 파라미터로 넘겨줌.
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    // cell 클릭 시 선택된 cell의 data를 이전 화면(calculatorView)으로 delegate를 사용해 전달
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dataToSend : String = items[indexPath.row]
        //print("clicked : \(items[indexPath.row])")
        
        self.delegate?.sendDataToCalculatorView(data: dataToSend)
        self.navigationController?.popViewController(animated: true)
        
    }
    
}
