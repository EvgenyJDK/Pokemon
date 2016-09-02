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
  
//        albumViewModel.indexRow?.asObservable()
//        .subscribeNext({ resultId in
// 
//        })
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

        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        self.albumViewModel.indexRow = Observable.just(indexPath.row)
        print(indexPath.row)
        
        self.performSegueWithIdentifier("showAlbumPhotos", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
      
        let photoController : CollectionViewController = segue.destinationViewController as! CollectionViewController
        
                print ("transition")
         }
        
}