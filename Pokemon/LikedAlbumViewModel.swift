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
    var likedUserName : Variable<User?> = Variable(nil)
    
    
    init () {
      
        AlbumStorage.storageLikedAlbumId.asObservable()
            .flatMap{ (albumId : Set<Int>) -> Observable<[Album]> in
                return self.albumApiService.getLikedAlbums(albumId)
            }
            .subscribeNext { (likedAlbums :[Album]) in
                self.likedAlbumList.value = likedAlbums
//                self.albumApiService.getUsersByAlbum(likedAlbums)
//       
//                    .subscribeNext({ (users : [User]) in
//                    self.likedUserNameList.value = users
//                         print("LIKED INIT = \(self.likedUserNameList.value)")
//                })
        }
        .addDisposableTo(bag)
    }

    
    func getUserName (likedAlbum : Album) {
        
        albumApiService.getUserNameByAlbum(likedAlbum)
            .subscribeNext{ (user : User) in
                print("GET ~~~~~~ = \(user.name)")
                self.likedUserName.value = user
            }
            .addDisposableTo(bag)
        
    }
    
    
    func changeAlbumStatusLike (rowIndex : Int, likeStatus : Bool) {
        print("LIKE MODEL = \(rowIndex)")
        print("LIKE MODEL = \(likeStatus)")
        AlbumApiService().changeAlbumStatusLike(rowIndex+1, likeStatus: likeStatus)
    }
    
}





