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
        
        self.cellViewModel!.switchLikeStatus.asObservable()
            .subscribeNext { (likeStatus : Bool) in
            self.checkSwitch.setOn(likeStatus, animated: false)
        }
        .addDisposableTo(self.disposeBag)
    }
    
}

