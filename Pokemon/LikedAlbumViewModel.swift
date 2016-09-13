//
//  LikedAlbumViewModel.swift
//  Pokemon
//
//  Created by Evgeny on 9/6/16.
//  Copyright © 2016 Evgeny. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class LikedAlbumViewModel {
    
    private let albumApiService = AlbumApiService()
    private let bag = DisposeBag()

    var likedAlbumList : Variable <[Album]> = Variable([])
    var likedUserNameList : Variable <[User]> = Variable([])
    
    init () {
      
        AlbumStorage.storageLikedAlbumId.asObservable()
            .flatMap{ (albumId : Set<Int>) -> Observable<[Album]> in
                return self.albumApiService.getLikedAlbums(albumId)
            }
            .subscribeNext { (likedAlbums :[Album]) in
                self.likedAlbumList.value = likedAlbums
                self.albumApiService.getUsersByAlbum(likedAlbums)
        }
        .addDisposableTo(bag)
    }

    
    func changeAlbumStatusLike (rowIndex : Int, likeStatus : Bool) {
        AlbumApiService().changeAlbumStatusLike(rowIndex+1, likeStatus: likeStatus)
    }
    
}





