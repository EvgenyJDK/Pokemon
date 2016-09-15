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
        print("AllAlbumCell setSwitch = \(checkSwitch.on)")
        cellViewModel?.setAlbumStatusLike(checkSwitch.on)
    }

    
    func setAlbumData (cellViewModel : CellViewModel) {

        self.cellViewModel = cellViewModel
        
        self.id.text = String (cellViewModel.album.albumId!)
        self.title.text = cellViewModel.album.title
        self.userName.text = cellViewModel.user!.name
    }
    
    
//    func setAlbumDataA (album : Album, index : Int) {
//        
//        print("setAlbumDataA")
//        self.albumViewModel?.albumList.value[index].albumId = album.albumId
//        self.albumViewModel?.albumList.value[index].title = album.title
//    }


    
 }

