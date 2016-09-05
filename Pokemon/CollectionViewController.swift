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
    
//    private let leftAndRightPaddings : CGFloat = 32.0
//    private let numberofItemsPerRow : CGFloat = 3.0
//    private let heightAdjustment : CGFloat = 30.0
    
    var photoViewModel : PhotoViewModel?
    
    @IBOutlet weak var image: UIImageView!

    override func viewDidLoad() {
        
//        let width = (CGRectGetWidth(collectionView!.frame)) - leftAndRightPaddings / numberofItemsPerRow
//        let layout = collectionViewLayout as! UICollectionViewFlowLayout
//        layout.itemSize = CGSizeMake(width, heightAdjustment)
        
        photoViewModel?.photo.asObservable()
            .subscribeNext({ (photo :[Photo]) in
            print ("COLLECTION = \(self.photoViewModel?.albumDetails.value.title)")
          
        }
        ).addDisposableTo(bag)
    }
    
    
//    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
//        return 1
//    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return (photoViewModel?.photo.value.count)!
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
 
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

        let label = photoCell.viewWithTag(1) as! UILabel
        label.text = photoViewModel?.photo.value[indexPath.item].title

        return photoCell
    }
    
    
}