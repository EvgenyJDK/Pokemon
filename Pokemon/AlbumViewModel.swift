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

//    var albums : Variable<[Album]> = Variable([])
    var photoViewModel : Variable<PhotoViewModel?> = Variable(nil)
    
//    var like : Variable <[Bool]> = Variable([])
  

    init () {
        
        albumApiService.getAllAlbums()
            .subscribe(onNext: { resultAlbum in
                self.albumList.value = resultAlbum
                print ("INIT = \(self.albumList.value)")
                },
                onError: { errorAlbum in
                    self.albumList.value = []
            }).addDisposableTo(bag)
        
        albumApiService.getUserName()
            .subscribe(onNext: { resultUser in
                self.userList.value = resultUser
                }, onError: { errorUser in
                    self.userList.value = []
            })
            .addDisposableTo(bag)
    }

    func initPhotoModelByRowIndex (rowIndex : Int) {
        
        self.photoViewModel.value = PhotoViewModel(album : albumList.value[rowIndex])
        print (self.photoViewModel.value)
    }
    

    var likedAlbums : Variable <[LikedAlbumViewModel]> = Variable([])
 
    
    func  getLikedAlbums(rowIndex : Int) {
        print(rowIndex)

        
    }
 
    
    
        var like : Observable <Bool>? {
            didSet {
                like?.subscribe(onNext: { (like) in
                    print (like)
//                    self.albumApiService.
                    }
                ).addDisposableTo(bag)
            }
//            return Observable.just(false)
        }
  

    
    
    //    var indexRow : Observable<Int>? {
    //        didSet {
    //            print(indexRow)
    //            print ("before didset")
    //            indexRow?.subscribe(onNext: { albumId in
    //
    //                print("in didset =\(albumId)")
    //                self.albumApiService.getAlbumDetails(albumId)
    //                })
    //            print("Hello")
    //        }
    //    }
}