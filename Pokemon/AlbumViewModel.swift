//
//  AlbumViewModel.swift
//  Pokemon
//
//  Created by Evgeny on 8/31/16.
//  Copyright © 2016 Evgeny. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class AlbumViewModel {
    
    private let albumApiService = AlbumApiService()
    private let bag = DisposeBag()
    
    let albumList : Variable <[Album]> = Variable([])
    let userList : Variable <[User]> = Variable([])

    var photoViewModel : Variable<PhotoViewModel?> = Variable(nil)
    var cellViewModelList : Variable <[CellViewModel]> = Variable([])
 
    
    init () {
        
        albumApiService.getAllAlbums()
            .map { (allAlbums : [Album]) -> [CellViewModel] in
                return allAlbums.map { (album : Album) -> CellViewModel in
                    return CellViewModel(album : album)
                }
        }
            .subscribeNext { (cellViewModels : [CellViewModel]) in
            self.cellViewModelList.value = cellViewModels
        }
        .addDisposableTo(bag)

        
//        albumApiService.getAllAlbums()
//            .subscribe(onNext: { resultAlbum in
//                self.albumList.value = resultAlbum
//                print ("INIT = \(self.albumList.value)")
//                },
//                onError: { errorAlbum in
//                    self.albumList.value = []
//            }).addDisposableTo(bag)
//        
//        albumApiService.getUserName()
//            .subscribe(onNext: { resultUser in
//                self.userList.value = resultUser
//                }, onError: { errorUser in
//                    self.userList.value = []
//            })
//            .addDisposableTo(bag)
    }

    
    func initPhotoModelByRowIndex (rowIndex : Int) {
        self.photoViewModel.value = PhotoViewModel (cellViewModel : cellViewModelList.value[rowIndex])
//        self.photoViewModel.value = PhotoViewModel(album : albumList.value[rowIndex])
//        print (self.photoViewModel.value)
    }

    
    func setAlbumStatusLike (rowIndex : Int, likeStatus : Bool) {
        AlbumStorage.setAlbumStatusLike(rowIndex+1, likeStatus: likeStatus)
    }
    
}


