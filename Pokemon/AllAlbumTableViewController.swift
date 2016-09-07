//
//  AllAlbumTableViewController.swift
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

class AllAlbumTableViewController: UITableViewController {
    
    private let albumViewModel = AlbumViewModel()
    private let bag = DisposeBag()
//    private let photoCell = PhotoCollectionViewCell()
//    private let albumCell = AllAlbumCell()
    
    @IBOutlet var allAlbumsView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        albumViewModel.albumList.asObservable()
            .subscribeNext { result in
                self.allAlbumsView.reloadData()
            }
            .addDisposableTo(bag)
        
        albumViewModel.userList.asObservable()
            .subscribeNext({ resultUser in
            })
            .addDisposableTo(bag)
        
//        albumViewModel.like?.asObservable()
//            .subscribeNext({ like in
//            print ("All switch are false")
//        })

    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumViewModel.albumList.value.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let tableCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! AllAlbumCell
        
        let album = albumViewModel.albumList.value[indexPath.row]
        
        tableCell.title.text = album.title
        tableCell.id.text = String(album.albumId!)
        tableCell.userName.text = albumViewModel.userList.value[Int(album.userId!)!-1].name
        
//        tableCell.checkSwitch.on = false
        
        tableCell.setupSwitch(self.albumViewModel.albumList.value[indexPath.row].like!)
        
        
        tableCell.checkSwitch.rx_value.asObservable()
            .subscribeNext { (like : Bool) in
//                print (like)
//                print(indexPath.row)
//                print ("SWITCH = \(tableCell.checkSwitch.on.boolValue)")
                
                let a = self.albumViewModel.getLikedAlbums(indexPath.row, likeStatus: like)
                
//                return self.albumViewModel.getLikedAlbums(indexPath.row, likeStatus: like)
//                print("AAAAA = \(a)")
                
        }
        .addDisposableTo(tableCell.disposeBag)
      
        
        return tableCell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        albumViewModel.initPhotoModelByRowIndex(indexPath.row)

        self.performSegueWithIdentifier("showAlbumPhotos", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        let photoController : PhotoCollectionViewController = segue.destinationViewController as! PhotoCollectionViewController
        
        photoController.photoViewModel = self.albumViewModel.photoViewModel.value
        print ("transition")
    }

}
