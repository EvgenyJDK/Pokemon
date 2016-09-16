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
        
        
        AlbumStorage.storageLikedAlbumId.asObservable()
            .map{ (likedSet : Set<Int>) -> Int in
                return (likedSet.filter{ (likedOne : Int) -> Bool in
                    self.checkSwitch.setOn(likedSet.contains(albumId), animated: false)
                    return likedSet.contains(albumId)
                    }
                    ).first!
                
        }
    }
    
}

