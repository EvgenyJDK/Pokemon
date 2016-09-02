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


//    var indexRow : Observable<Int>? {
     var indexRow : Variable<PhotoViewModel?> {
        
//        didSet {
//            print(indexRow)
//            print ("before didset")
//            indexRow.subscribe(onNext: { albumId in
//                
//                print("in didset =\(albumId)")
//                self.albumApiService.getAlbumDetails(albumId)
//                })
//            print("Hello")
//        }
    }
 
    
    init () {
        
        albumApiService.getAllAlbums()
            .subscribe(onNext: { resultAlbum in
                self.albumList.value = resultAlbum
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
}