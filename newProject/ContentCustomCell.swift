//
//  ContentCustomCell.swift
//  newProject
//
//  Created by 김수빈 on 07/08/2019.
//  Copyright © 2019 김수빈. All rights reserved.
//

import Foundation
import UIKit

// UIImageView와 UILabel을 가진 CustomCell을 만들어주는 custom class
// cell identifier : ContentCustomCell(클래스 명과 동일)

class ContentCustomCell : UITableViewCell {
    
    @IBOutlet var cellImageView: UIImageView!
    @IBOutlet var cellLabel: UILabel!
}
