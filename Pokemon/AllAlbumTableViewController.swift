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

        albumViewModel.cellViewModelList.asObservable()
            .subscribeNext { (cellViewModels : [CellViewModel]) in
                self.allAlbumsView.reloadData()
            }
            .addDisposableTo(bag)
    }
   
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumViewModel.cellViewModelList.value.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let albumCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! AllAlbumCell
        albumCell.setAlbumData(albumViewModel.cellViewModelList.value[indexPath.row])
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
    }

}
