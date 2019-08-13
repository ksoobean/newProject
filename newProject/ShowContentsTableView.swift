//
//  ShowContentsTableView.swift
//  newProject
//
//  Created by 김수빈 on 09/08/2019.
//  Copyright © 2019 김수빈. All rights reserved.
//

import UIKit

class ShowContentsTableView: UITableViewCell {
    
    @IBOutlet var cellImage: UIImageView!
    @IBOutlet var cellLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        cellImage.image = nil
        cellLabel.text = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
