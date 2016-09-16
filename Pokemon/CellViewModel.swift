//
//  CellViewModel.swift
//  Pokemon
//
//  Created by Evgeny on 9/15/16.
//  Copyright © 2016 Evgeny. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class CellViewModel {
    
    private let albumApiService = AlbumApiService()
    private (set) var album : Album
    private (set) var user : User? = nil
    private let bag = DisposeBag()

   
    
    
//    var switchLikeStatus : Variable<Bool> = Variable(false)

//    var switchLikeStatus : Observable<Bool> {
//        didSet {
//       
//            return false.
//            
//            
////            switchLikeStatus = false as! Observable <Bool>
//        }
//    }
    
    
    func getSwitchLikeStatus(albumId : Int) -> Bool {
        self.albumApiService.getSwitchLikeStatusByAlbumId(albumId)

        return false
    }

    
    init (album : Album) {

        self.album = album
        albumApiService.getUserNameByAlbum(self.album)
            .subscribeNext { (user : User) in
            self.user = user
        }
        .addDisposableTo(bag)
    }
    
    
    func setAlbumStatusLike (likeStatus : Bool) {
       let albumId = self.album.albumId!
        AlbumStorage.setAlbumStatusLike(albumId, likeStatus: likeStatus)
    }
    
}
