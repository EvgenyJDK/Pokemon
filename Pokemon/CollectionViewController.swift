//
//  CollectionViewController.swift
//  Pokemon
//
//  Created by Evgeny on 8/31/16.
//  Copyright © 2016 Evgeny. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewController: UICollectionViewController {
    
    
    @IBOutlet weak var image: UIImageView!
    
    
//    var Array = [String]()
    
 var Array = ["sdsada", "sdasd", "sadasd", "dsfdsfdsf"]
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 3
        return Array.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as UICollectionViewCell
        
        var button = cell.viewWithTag(1) as! UILabel
        
        button.text = Array [indexPath.row]
        
        return cell
    }
    
    
}