//
//  CollectionViewController.swift
//  Pokemon
//
//  Created by Evgeny on 8/31/16.
//  Copyright © 2016 Evgeny. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import SDWebImage
import ImageLoader

class CollectionViewController: UICollectionViewController {
    
    private let photoCell = AlbumPhotoCollectionViewCell()
    private let bag = DisposeBag()
    private let leftAndRightPaddings : CGFloat = 8.0
    
    var photoViewModel : PhotoViewModel?
    
    @IBOutlet weak var image: UIImageView!

//    var Array = ["sdsada", "sdasd", "sadasd", "dsfdsfdsf"]
    
    override func viewDidLoad() {
        
//        let width = (CGRectGetWidth(collectionView.frame))
        
        photoViewModel?.photo.asObservable()
            .subscribeNext({ (photo :[Photo]) in
            print ("COLLECTION = \(self.photoViewModel?.albumDetails.value.title)")
          
        }
        ).addDisposableTo(bag)
    }
    
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 3
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return Array.count
         return (photoViewModel?.photo.value.count)!
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as UICollectionViewCell
 
        let photoCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! AlbumPhotoCollectionViewCell

//        print ("CELL INDEX PATH ITEM = \(photoViewModel?.photo.value[indexPath.item])")
//        print ("CELL = \(photoViewModel?.photo.value[indexPath.item].url)")
        
        
        if let url = photoViewModel?.photo.value[indexPath.item].url {
            print(url)
            photoCell.imageViewLink.load(url)
        }
        else {
        print ("hello")
        }
        
        let title = photoViewModel?.photo.value[indexPath.item].title
        print((title)!)
       let t = photoCell.viewWithTag(1) as! UILabel
        t.text = photoViewModel?.photo.value[indexPath.item].title
        
//        let button = cell.viewWithTag(1) as! UILabel
//        button.text = Array [indexPath.row]
        
        return photoCell
    }
    
    
}