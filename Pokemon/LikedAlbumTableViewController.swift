//
//  LikedAlbumTableViewController.swift
//  Pokemon
//
//  Created by Evgeny on 9/6/16.
//  Copyright © 2016 Evgeny. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import ImageLoader

class  LikedAlbumTableViewController : UITableViewController {

    private let albumViewModel = AlbumViewModel()
//    private let storageAlbumViewModel = StorageAlbumViewModel()
    private let bag = DisposeBag()
    
    @IBOutlet weak var LikedAlbumView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print (" LIKED = \(albumViewModel.albumList.value.count)")
//         print (" LIKED = \(albumViewModel.albumList.value[2].like)")
        
//        print (albumViewModel.storageAlbumViewModel.value.count)
//        print (" LIKED = \(albumViewModel.storageAlbumViewModel.value[2].title)")
//        print (" LIKED = \(albumViewModel.storageAlbumViewModel.value[2].like)")
//        storageAlbumViewModel[1].
        
        
        StorageAlbumViewModel.storageAlbumViewModel.asObservable()
            .subscribeNext { (result : [Album]?) in
            
                print("SUBS = \(StorageAlbumViewModel.storageAlbumViewModel.value?.count)")
                 print("SUBS = \(StorageAlbumViewModel.storageAlbumViewModel.value!.isEmpty)")
//                StorageAlbumViewModel.storageAlbumViewModel.value![1].like
        }
        
        print ("LIKED = \(StorageAlbumViewModel.storageAlbumViewModel.value?.count)")
        
//        albumViewModel.albumList.asObservable()
//        .subscribeNext { result in
//            self.LikedAlbumView.reloadData()
//        }
//        .addDisposableTo(bag)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumViewModel.albumList.value.count
//        return 5
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let likedAlbumCell  = tableView.dequeueReusableCellWithIdentifier("likedCell", forIndexPath: indexPath) as! LikedAlbumCell
        
         let likedAlbum = StorageAlbumViewModel.storageAlbumViewModel.value![indexPath.row]
        
        
         print("SUBS2 = \(StorageAlbumViewModel.storageAlbumViewModel.value![indexPath.row].like)")
//        let likedAlbum = albumViewModel.albumList.value[indexPath.row]
        
        likedAlbumCell.idLike.text = String(likedAlbum.albumId!)
        likedAlbumCell.titleLike.text = likedAlbum.title
        likedAlbumCell.nameLike.text = albumViewModel.userList.value[Int(likedAlbum.userId!)!-1].name
        
        likedAlbumCell.setupSwitch(StorageAlbumViewModel.storageAlbumViewModel.value![indexPath.row].like!)

        return likedAlbumCell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        albumViewModel.initPhotoModelByRowIndex(indexPath.row)
        self.performSegueWithIdentifier("showAlbumPhotos2", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let photoController : PhotoCollectionViewController = segue.destinationViewController as! PhotoCollectionViewController
        
        photoController.photoViewModel = self.albumViewModel.photoViewModel.value
    }
    
}