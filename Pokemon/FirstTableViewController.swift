//
//  FirstTableViewController.swift
//  Pokemon
//
//  Created by Evgeny on 8/31/16.
//  Copyright © 2016 Evgeny. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import SDWebImage
import ImageLoader

class FirstTableViewController : UITableViewController {
    
    private let albumViewModel = AlbumViewModel()
    private let bag = DisposeBag()
    private let photoCell = AlbumPhotoCollectionViewCell()
    
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
        
        let tableCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UserCell
        
        let album = albumViewModel.albumList.value[indexPath.row]
        
        tableCell.title.text = album.title
        tableCell.id.text = String(album.albumId!)
        tableCell.userName.text = albumViewModel.userList.value[Int(album.userId!)!-1].name

        return tableCell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showAlbumPhotos", sender: self)
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
      
        if segue.identifier == "showAlbumPhotos" {
            
                        print ("transition")
            
//            let url = "http://cs623421.vk.me/623421649/1f74a/d9ACLtsR5DM.jpg"
//            let url = "http://cs623421.vk.me/623421649/1f74a/d9ACLtsR5DM.jpg"
            
        photoCell.imageViewLink.load("http://placehold.it/600/b0f7cc")
        photoCell.imageViewLink.sd_setImageWithURL(NSURL(string: "http://placehold.it/600/b0f7cc")!)


        }

    }
    
    
}