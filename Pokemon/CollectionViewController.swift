//
//  CollectionViewController.swift
//  Pokemon
//
//  Created by Evgeny on 8/31/16.
//  Copyright © 2016 Evgeny. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
import ImageLoader

class CollectionViewController: UICollectionViewController {
    
    private let photoCell = AlbumPhotoCollectionViewCell()
    var photoViewModel : PhotoViewModel?
    
    
    @IBOutlet weak var image: UIImageView!

    
    var Array = ["sdsada", "sdasd", "sadasd", "dsfdsfdsf"]
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Array.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as UICollectionViewCell
 

        //            let url = "http://cs623421.vk.me/623421649/1f74a/d9ACLtsR5DM.jpg"
        //            let url = "http://cs623421.vk.me/623421649/1f74a/d9ACLtsR5DM.jpg"
        //            let url = "http://placehold.it/600/b0f7cc"
   
//        photoCell.imageViewLink.load("http://placehold.it/600/b0f7cc")

        //        photoCell.imageViewLink.sd_setImageWithURL(NSURL(string: "http://placehold.it/600/b0f7cc")!)
        //            photoCell.imageViewLink.sd_setImageWithURL(NSURL(string: url))
        //        }
        //    }

 
        
        
        
//        let button = cell.viewWithTag(1) as! UILabel
//        
//        button.text = Array [indexPath.row]
        
//        cell.v
        
        return cell
    }
    
    
}