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

    var likedCellViewModelList : Variable <[CellViewModel]> = Variable([])
    var photoViewModel : Variable <PhotoViewModel?> = Variable(nil)


    var switchLikeStatus : Variable <Bool> = Variable(false)

    
    init () {
 
        AlbumStorage.storageLikedAlbumId.asObservable()
            .flatMap { (likedAlbumId : Set<Int>) -> Observable<[Album]> in
                self.switchLikeStatus.value = false
                return self.albumApiService.getLikedAlbums(likedAlbumId)
            }
            .map{ (albums : [Album]) -> [CellViewModel] in
                return albums.map{ (album : Album) -> CellViewModel in
                    return CellViewModel (album : album)
                }
            }
            .subscribeNext { [unowned self] (cells: [CellViewModel]) in
                self.likedCellViewModelList.value = cells
        }
        .addDisposableTo(bag)
    }

    
    func initPhotoModelByRowIndex (rowIndex : Int) {
        self.photoViewModel.value = PhotoViewModel (cellViewModel : likedCellViewModelList.value[rowIndex])
    }


    
    func setAlbumStatusLike (rowIndex : Int, likeStatus : Bool) {
        AlbumStorage.setAlbumStatusLike(rowIndex+1, likeStatus: likeStatus)
    }
    
    
    
    //    var likedUserName : Variable<User?> = Variable(nil)
    
    
    //    func getUserNameByAlbum (likedAlbum : Album) {
    //
    //        albumApiService.getUserNameByAlbum(likedAlbum)
    //            .subscribeNext{ (user : User) in
    //                print("GET ~~~~~~ = \(user.name)")
    //                self.likedUserName.value = user
    //            }
    //            .addDisposableTo(bag)
    //    }
    
    
}





