//
//  PhotoCollectionViewController.swift
//  Pokemon
//
//  Created by Evgeny on 9/6/16.
//  Copyright © 2016 Evgeny. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import ImageLoader
import RxDataSources

class PhotoCollectionViewController : UICollectionViewController {
    
    private let bag = DisposeBag()

    var photoViewModel : PhotoViewModel?
    var collectionDataSource: RxCollectionViewSectionedAnimatedDataSource<PhotoSection>?
    
    @IBOutlet weak var image: UICollectionView!
//    @IBOutlet weak var image: UIImageView!  /* UICollectionView! */
    
    override func viewDidLoad() {
        
/*        photoViewModel?.photo.asObservable()
            .subscribeNext{ (photo :[Photo]) in
            }
            .addDisposableTo(bag)
*/
        
        self.image.delegate = nil
        self.image.dataSource = nil
        
        image.rx_setDelegate(self)
        .addDisposableTo(bag)
        
        let collectionDataSource = RxCollectionViewSectionedAnimatedDataSource<PhotoSection>()
        
        photoViewModel?.photoSection.asObservable()
            .bindTo(image.rx_itemsWithDataSource(collectionDataSource))
        .addDisposableTo(bag)
        
        
        collectionDataSource.cellFactory = { [weak self] (dataSource, collectionView, indexPath, photo ) in
            let photoCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! PhotoCollectionViewCell
           
            photoCell.imageViewLink.load((self?.photoViewModel?.photoSection.value.first?.items[indexPath.row].url)!)

            photoCell.label.text = self!.photoViewModel?.photoSection.value.first?.items[indexPath.row].title
            
            return photoCell
        }
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (photoViewModel?.photoSection.value.first?.items.count)!
/*        return (photoViewModel?.photo.value.count)!       */
    }
    
/*    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let photoCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! PhotoCollectionViewCell
        
        if let url = photoViewModel?.photo.value[indexPath.item].url {
            photoCell.imageViewLink.load(url)
        }
        else {
            print ("There is no image")
        }
        
        let label = photoCell.viewWithTag(1) as! UILabel
        label.text = photoViewModel?.photo.value[indexPath.item].title
        return photoCell
    }
 */
    
}