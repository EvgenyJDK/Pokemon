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
        
        print("LIKED VIEWMODEL INIT")
      
        AlbumStorage.storageLikedAlbumId.asObservable()
            .flatMap{ (albumId : Set<Int>) -> Observable<[Album]> in
                return self.albumApiService.getLikedAlbums(albumId)
            }
            
//            .flatMap{ (albums : [Album]) -> Observable<[User]>in
//                return self.albumApiService.getUsersByAlbum(albums)
//            }
//            .subscribeNext({ (users : [User]) in
//                
//            })
            .subscribeNext { (likedAlbums :[Album]) in
                self.likedAlbumList.value = likedAlbums
        }
        .addDisposableTo(bag)
        

        //        AlbumStorage.storageLikedAlbumId.asObservable()
        //            .flatMapLatest { (albumId : Set<Int>) -> Observable<[User]> in
        //            self.albumApiService.getLikedUserName(albumId)
        //        }
        //            .subscribe(onNext: { (likedUsers : [User]) in
        //            self.likedUserNameList.value = likedUsers
        ////                print ("USERNAME = \(self.likedUserNameList.value[0].userName)")
        //            }
        //                , onError: { (ErrorType) in
        //                }
        //        ).addDisposableTo(bag)
    }

    
    func changeAlbumStatusLike (rowIndex : Int, likeStatus : Bool) {
        AlbumApiService().changeAlbumStatusLike(rowIndex+1, likeStatus: likeStatus)
        
    }
 
}





