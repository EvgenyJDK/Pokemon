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
    }
   
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumViewModel.albumList.value.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let albumCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! AllAlbumCell
        
 
        let album = albumViewModel.albumList.value[indexPath.row]
        
        albumCell.title.text = album.title
        albumCell.id.text = String(album.albumId!)
        albumCell.userName.text = albumViewModel.userList.value[album.userId!-1].name
        
        albumCell.setupSwitch(self.albumViewModel.albumList.value[indexPath.row].like!)

        albumCell.likeSwitch.rx_value.asObservable()
            .subscribeNext { [weak self] (like : Bool) in
            self!.albumViewModel.changeAlbumStatusLike(indexPath.row, likeStatus: like)
            }
            .addDisposableTo(albumCell.disposeBag)
        return albumCell
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
