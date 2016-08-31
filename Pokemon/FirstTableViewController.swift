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

    @IBOutlet var allAlbumsView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        albumViewModel.albumList.asObservable()
        .subscribeNext { result in

            self.title = result[1]
        }
        
//        
//        override func tableView(<#T##tableView: UITableView##UITableView#>, numberOfRowsInSection: <#T##Int#>) -> Int {
//            return 3
//        }
//        
//        
//        override func tableView(<#T##tableView: UITableView##UITableView#>, cellForRowAtIndexPath: <#T##NSIndexPath#>) -> UITableView  {
//        
//            let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
//            
//            
//        }
        
  
    }
}