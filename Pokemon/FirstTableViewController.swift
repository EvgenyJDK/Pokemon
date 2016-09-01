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

class FirstTableViewController : UITableViewController {

    private let albumViewModel = AlbumViewModel()

    @IBOutlet var allAlbumsView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        albumViewModel.albumList.asObservable()
        .subscribeNext { result in

        }
    }
   
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumViewModel.albumList.value.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var tableCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! userCell

        tableCell.title.text = albumViewModel.albumList.value[indexPath.row].title
        tableCell.id.text = String(albumViewModel.albumList.value[indexPath.row].albumId!)
        
//        tableCell.title.text = albumViewModel.albumList.value[indexPath.row]

        return tableCell
    }
}