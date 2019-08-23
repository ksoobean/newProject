//
//  CollectionView.swift
//  newProject
//
//  Created by 김수빈 on 2019/08/23.
//  Copyright © 2019 김수빈. All rights reserved.
//

import Foundation
import UIKit

class CollectionView : UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var collectionItems : [String] = ["A","B","C","D","E","F","G","H","I","J"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib.init(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "collectionCell")
        
    }
    
    
}

extension CollectionView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.collectionItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath : IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionViewCell
        
        cell.itemLabel?.text = collectionItems[indexPath.row]
        cell.itemImage?.image = UIImage(named: "image1.jpg")
        
        return cell
    }
    
    
    
}
