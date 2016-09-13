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
   
    private let likedAlbumViewModel = LikedAlbumViewModel()
    private let bag = DisposeBag()
    
    @IBOutlet weak var LikedAlbumView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        likedAlbumViewModel.likedAlbumList.asObservable()
            .subscribeNext { (likedAlb : [Album]) in
                self.LikedAlbumView.reloadData()
            }
            .addDisposableTo(bag)
        
 
        
        
  
//        likedAlbumViewModel.likedAlbumList.asObservable()
//            .subscribe(onNext: { (likedAlbList : [Album]) in
//            print(likedAlbList)
//            })
        
//    albumViewModel.storageLikedAlbumId.asObservable()
//        .subscribeNext { (albumId :[Int]) in
//            print("LIKED CONTROLLER = \(albumId)")
//        }
     
//        AlbumStorage.storageLikedAlbumId
//            .asObservable()
//            .subscribeNext { (int :[Int]) in
//                print("LIKED CONTROLLER = \(int)")
//            self.LikedAlbumView.reloadData()
//        }

        
    }

    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return likedAlbumViewModel.likedAlbumList.value.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let likedAlbumCell  = tableView.dequeueReusableCellWithIdentifier("likedCell", forIndexPath: indexPath) as! LikedAlbumCell
        

        let likedAlbum = likedAlbumViewModel.likedAlbumList.value[indexPath.row]
        
        likedAlbumCell.idLike.text = String(likedAlbum.albumId!)
        
        print (likedAlbum.albumId!)
        likedAlbumCell.titleLike.text = likedAlbum.title
        likedAlbumCell.nameLike.text = likedAlbumViewModel.likedAlbumList.value[Int(likedAlbum.userId!)!-1]
        
        
//        let likedAlbum = 
        
//        let likedAlbum = LikedAlbumViewModel.
//       
//        
//        
//        let likedAlbum = StorageAlbumViewModel.storageAlbumViewModel.value![indexPath.row]
//      
//        likedAlbumCell.idLike.text = String(likedAlbum.albumId!)
//        likedAlbumCell.titleLike.text = likedAlbum.title
//        likedAlbumCell.nameLike.text = albumViewModel.userList.value[Int(likedAlbum.userId!)!-1].name
//        
//        likedAlbumCell.setupSwitch(StorageAlbumViewModel.storageAlbumViewModel.value![indexPath.row].like!)
//
//
//        likedAlbumCell.likeSwitch.rx_value.asObservable()
//            .subscribeNext { (like : Bool) in
//                self.albumViewModel.changeAlbumStatusLike(indexPath.row, likeStatus: like)
//            }
//            .addDisposableTo(likedAlbumCell.disposeBag)
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














































/*     StorageAlbumViewModel.storageLikedAlbumId
 .asObservable()
 .subscribeNext { (int :[Int]) in
 print("LIKED CONTROLLER = \(int)")
 //            self.LikedAlbumView.reloadData()
 }
 */



//     StorageAlbumViewModel.storageAlbumViewModel.asObservable()
//        .map { $0?.filter {$0.like!
//            }
//        }
//        .subscribeNext { (subscribe : [Album]?) in
//            print("LIKED = \(subscribe![1].like) + \(subscribe![1].title)")
//            self.LikedAlbumView.reloadData()
//        }



//        StorageAlbumViewModel.storageAlbumViewModel.asObservable()
//            .subscribeNext { (result : [Album]?) in
//                self.LikedAlbumView.reloadData()
//                print("SUBS = \(StorageAlbumViewModel.storageAlbumViewModel.value?.count)")
//                 print("SUBS = \(StorageAlbumViewModel.storageAlbumViewModel.value!.isEmpty)")
//        }



/*
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
*/