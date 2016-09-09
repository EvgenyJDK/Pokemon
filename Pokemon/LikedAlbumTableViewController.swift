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
    private let bag = DisposeBag()
    
    @IBOutlet weak var LikedAlbumView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
     StorageAlbumViewModel.storageAlbumViewModel.asObservable()
        .map { $0?.filter {$0.like!
            }
        }
        .subscribeNext { (subscribe : [Album]?) in
            print("LIKED = \(subscribe![1].like) + \(subscribe![1].title)")
            self.LikedAlbumView.reloadData()
        }
        
//        StorageAlbumViewModel.storageAlbumViewModel.asObservable()
//            .subscribeNext { (result : [Album]?) in
//                self.LikedAlbumView.reloadData()
//                print("SUBS = \(StorageAlbumViewModel.storageAlbumViewModel.value?.count)")
//                 print("SUBS = \(StorageAlbumViewModel.storageAlbumViewModel.value!.isEmpty)")
//        }
    
        print ("LIKED = \(StorageAlbumViewModel.storageAlbumViewModel.value!.count)")
    }

    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumViewModel.albumList.value.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let likedAlbumCell  = tableView.dequeueReusableCellWithIdentifier("likedCell", forIndexPath: indexPath) as! LikedAlbumCell
        
        let likedAlbum = StorageAlbumViewModel.storageAlbumViewModel.value![indexPath.row]

        
//        if StorageAlbumViewModel.storageAlbumViewModel.value![indexPath.row].like {
        
        print("SUBS2")
        print((StorageAlbumViewModel.storageAlbumViewModel.value![indexPath.row].like)!)
        
        
//        if ((StorageAlbumViewModel.storageAlbumViewModel.value![indexPath.row].like)!) {
        
        likedAlbumCell.idLike.text = String(likedAlbum.albumId!)
        likedAlbumCell.titleLike.text = likedAlbum.title
        likedAlbumCell.nameLike.text = albumViewModel.userList.value[Int(likedAlbum.userId!)!-1].name
        
        likedAlbumCell.setupSwitch(StorageAlbumViewModel.storageAlbumViewModel.value![indexPath.row].like!)

        
//        }
//        
//        else {
//            likedAlbumCell.idLike.text = ""
//            likedAlbumCell.titleLike.text = ""
//            //        likedAlbumCell.nameLike.text = albumViewModel.userList.value[Int(likedAlbum.userId!)!-1].name
//            likedAlbumCell.nameLike.text = ""
//            
//            likedAlbumCell.setupSwitch(StorageAlbumViewModel.storageAlbumViewModel.value![indexPath.row].like!)
//            
//        }
        

        likedAlbumCell.likeSwitch.rx_value.asObservable()
            .subscribeNext { (like : Bool) in
                self.albumViewModel.saveAlbumStatusLike(indexPath.row, likeStatus: like)
            }
            .addDisposableTo(likedAlbumCell.disposeBag)
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