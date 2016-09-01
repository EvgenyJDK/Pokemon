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

    private let albumApiService = AlbumApiService()
    private let albumViewModel = AlbumViewModel()

    var titles : [String] = []
    
    @IBOutlet var allAlbumsView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        albumViewModel.albumList.asObservable()
        .subscribeNext { result in
//            self.title = result[1]
            print (result.count)
            self.titles = result
        }
    }
   
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumViewModel.albumList.value.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var tableCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! userCell

        
        tableCell.title.text = albumViewModel.albumList.value[indexPath.row]

        return tableCell
    }
}