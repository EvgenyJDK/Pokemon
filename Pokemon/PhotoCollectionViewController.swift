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

class PhotoCollectionViewController : UICollectionViewController {
    
    private let bag = DisposeBag()

    var photoViewModel : PhotoViewModel?
    
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        
        photoViewModel?.photo.asObservable()
            .subscribeNext{ (photo :[Photo]) in
            }
            .addDisposableTo(bag)
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return (photoViewModel?.photo.value.count)!
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
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
}