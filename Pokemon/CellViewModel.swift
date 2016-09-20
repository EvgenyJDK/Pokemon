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
import RxDataSources

class CellViewModel {
    
    private let albumApiService = AlbumApiService()
    private (set) var album : Album
    private (set) var user : User? = nil
    private let bag = DisposeBag()

    var switchLikeStatus : Observable<Bool> {
 
    return AlbumStorage.storageLikedAlbumId.asObservable()
            .map{ (liked : Set<Int>) -> Bool in
            return liked.contains(self.album.albumId!)
        }
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
    
extension CellViewModel : IdentifiableType, Equatable {

    var identity : String {
        return "Hello"
    }
}


func ==(lhs: CellViewModel, rhs: CellViewModel) -> Bool {
    
    return lhs.album == rhs.album &&
        lhs.user == rhs.user

}

    
    

