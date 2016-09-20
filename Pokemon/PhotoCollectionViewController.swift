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
    
    override func viewDidLoad() {
        
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
    }
}