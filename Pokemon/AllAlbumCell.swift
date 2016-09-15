//
//  AllAlbumCell.swift
//  Pokemon
//
//  Created by Evgeny on 9/6/16.
//  Copyright © 2016 Evgeny. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
//import RxCocoa

class AllAlbumCell: UITableViewCell {
    
    private var cellViewModel : CellViewModel?
    private(set) var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        
        self.disposeBag = DisposeBag()
        super.prepareForReuse()
    }

    
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var checkSwitch: UISwitch!
    
    @IBAction func setSwitch(sender: UISwitch) {
        print("CELL = \(checkSwitch.on)")
        cellViewModel?.setAlbumStatusLike(checkSwitch.on)
    }

    
    func setAlbumData (cellViewModel : CellViewModel) {
        
        print("SET")
        self.cellViewModel = cellViewModel
        
        self.id.text = String (cellViewModel.album.albumId)
        self.title.text = cellViewModel.album.title
        self.userName.text = cellViewModel.user!.name
        

    }
    
    
    
    
//    let album = albumViewModel.albumList.value[indexPath.row]
//    
//    albumCell.title.text = album.title
//    albumCell.id.text = String(album.albumId!)
//    albumCell.userName.text = albumViewModel.userList.value[album.userId!-1].name
//    
//    AlbumStorage.storageLikedAlbumId.asObservable()
//    .subscribeNext { (set : Set<Int>) in
//    albumCell.likeSwitch.setOn(set.contains(album.albumId!), animated: false)
//    }.addDisposableTo(albumCell.disposeBag)
//    //albumCell.setupSwitch(self.albumViewModel.albumList.value[indexPath.row].like!)
//    
//    albumCell.likeSwitch.rx_value.asObservable()
//    .subscribeNext { [weak self] (like : Bool) in
//    self!.albumViewModel.setAlbumStatusLike(indexPath.row, likeStatus: like)
//    }
//    .addDisposableTo(albumCell.disposeBag)
    
    
    
    
}