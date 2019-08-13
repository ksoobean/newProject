//
//  WebKitView.swift
//  newProject
//
//  Created by 김수빈 on 13/08/2019.
//  Copyright © 2019 김수빈. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class WebKitViewController : UIViewController {
    
    @IBOutlet var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://www.google.co.kr")
        let request = URLRequest(url: url!)
        webView.load(request)
        
    }
}
