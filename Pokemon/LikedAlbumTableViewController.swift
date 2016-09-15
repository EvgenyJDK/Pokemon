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

//    private let albumViewModel = AlbumViewModel()
   
    private let likedAlbumViewModel = LikedAlbumViewModel()
    private let bag = DisposeBag()
    
    @IBOutlet weak var LikedAlbumView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        likedAlbumViewModel.likedCellViewModelList.asObservable()
            .subscribeNext { (likedCellVMList :[CellViewModel]) in
            self.LikedAlbumView.reloadData()
        }
        .addDisposableTo(bag)
        
        
/*        likedAlbumViewModel.likedAlbumList.asObservable()
            .subscribeNext { [weak self] (likedAlbums : [Album]) in
                print("LIKE CONTROLLER = \(likedAlbums)")
                self!.LikedAlbumView.reloadData()
                print(AlbumStorage.storageLikedAlbumId.value)
            }
            .addDisposableTo(bag)
        
        setup()     
*/

    }

    
/*    private func setup() {
        likedAlbumViewModel.likedAlbumOne.asObservable()
            .subscribeNext { (album : Album?) in
                self.LikedAlbumView.reloadData()
                print("SUBSCRIBE = \(album)")
        }
        .addDisposableTo(bag)
    }
*/

    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return likedAlbumViewModel.likedAlbumList.value.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let likedAlbumCell = tableView.dequeueReusableCellWithIdentifier("likedCell", forIndexPath: indexPath) as! AllAlbumCell

        
        likedAlbumCell.setAlbumData(likedAlbumViewModel.likedCellViewModelList.value[indexPath.row])
     
//        likedAlbumCell.setAlbumDataA(likedAlbumViewModel.likedAlbumList.value[indexPath.row], index: indexPath.row)
       

        
        
/*        let likedAlbumCell  = tableView.dequeueReusableCellWithIdentifier("likedCell", forIndexPath: indexPath) as! LikedAlbumCell

        let likedAlbum = likedAlbumViewModel.likedAlbumList.value[indexPath.row]
        
        likedAlbumCell.idLike.text = String(likedAlbum.albumId!)
        likedAlbumCell.titleLike.text = likedAlbum.title
        likedAlbumCell.nameLike.text = albumViewModel.userList.value[likedAlbum.userId!-1].name
        likedAlbumViewModel.getUserNameByAlbum(likedAlbum)
        likedAlbumCell.nameLike.text = likedAlbumViewModel.likedUserName.value!.name

        AlbumStorage.storageLikedAlbumId.asObservable()
            .subscribeNext { (set : Set<Int>) in
                likedAlbumCell.likeSwitch.setOn(set.contains(likedAlbum.albumId!), animated: false)
            }.addDisposableTo(likedAlbumCell.disposeBag)
        
        
         LOOP 
         likedAlbumCell.likeSwitch.rx_value.asObservable()
            .subscribeNext { [weak self] (like : Bool) in

                self!.likedAlbumViewModel.setAlbumStatusLike(indexPath.row, likeStatus: like)
            }
            .addDisposableTo(likedAlbumCell.disposeBag)

        let likedAlbum = likedAlbumViewModel.likedAlbumOne.value
        print(likedAlbumViewModel.likedAlbumOne.value)
        likedAlbumCell.idLike.text = String(likedAlbum?.albumId)
        likedAlbumCell.titleLike.text = likedAlbum?.title
*/
        return likedAlbumCell
    }

 
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
//        albumViewModel.initPhotoModelByRowIndex(indexPath.row)
        self.performSegueWithIdentifier("showAlbumPhotos2", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let photoController : PhotoCollectionViewController = segue.destinationViewController as! PhotoCollectionViewController
        
//        photoController.photoViewModel = self.albumViewModel.photoViewModel.value
    }
}

