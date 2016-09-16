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
import RxCocoa

class AllAlbumCell: UITableViewCell {
    
    private var cellViewModel : CellViewModel?
    private var albumViewModel : AlbumViewModel?
    private var likedAlbumViewModel : LikedAlbumViewModel?
    
    private(set) var disposeBag = DisposeBag()
    
    
    
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var checkSwitch: UISwitch!
    
    @IBAction func setSwitch(sender: UISwitch) {
        print("AllAlbumCell setSwitch = \(checkSwitch.on)")
        cellViewModel?.setAlbumStatusLike(checkSwitch.on)
    }

    
    override func prepareForReuse() {
        
        self.disposeBag = DisposeBag()
        super.prepareForReuse()
    }

    
    
    func setAlbumData (cellViewModel : CellViewModel) {
        
        self.cellViewModel = cellViewModel
        
        self.id.text = String (cellViewModel.album.albumId!)
        self.title.text = cellViewModel.album.title
        self.userName.text = cellViewModel.user!.name
        
        
        let albumId = cellViewModel.album.albumId!
//        let status = self.cellViewModel!.getSwitchLikeStatus(albumId)
//        self.checkSwitch.setOn(status, animated: false)
     
        
        
        self.likedAlbumViewModel?.switchLikeStatus.asObservable()
            .subscribeNext({ (likeStatus : Bool) in
                
                
            self.checkSwitch.setOn(likeStatus, animated: false)
        })
 
        
        
//        self.cellViewModel?.switchLikeStatus
//            .subscribeNext{ [weak self] (likeStatus : Bool) in
//                self?.checkSwitch.setOn(likeStatus, animated: false)
//        }
     
        
        
        
//        self.cellViewModel?.switchLikeStatus.asObservable()
//            .flatMap({ (Bool) -> ObservableConvertibleType in
//                self.cellViewModel?.getSwitchLikeStatus(albumId)
//            })
//            .subscribeNext{ (likeStatus : Bool) in
//                self.checkSwitch.setOn(false, animated: false)
//            }
//            .addDisposableTo(disposeBag)
        
        
    }

    
 }

