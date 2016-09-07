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
    
    let albumStatus : Variable<Bool> = Variable(false)
    
    var like : Variable<Bool> = Variable(false)
    var likedAlbums : Variable <Album?> = Variable(nil)
    
    var albumDetails : Variable <Album> = Variable(Album())

    init (likedAlbum : Album, likedStatus : Bool) {
        
        print ("LIKEDALBUM")
        print (likedAlbum.albumId!)
        print(likedStatus)
        
        self.albumDetails.value = likedAlbum
        self.albumDetails.asObservable()
            .flatMapLatest { (albumDetails : Album) -> Observable<Album> in
                return self.albumApiService.saveAlbumStatus(likedAlbum, likeStatus : likedStatus )
            }
            .subscribe(onNext: { (likedAlbums : Album) in
                self.likedAlbums.value = likedAlbums
                print ("~~~~~~~~~~~~~~~~~~~~~~~~~~")
                print(self.likedAlbums.value?.title)
                print(self.likedAlbums.value?.like)
                },
                onError: { (ErrorType) in
                    print ("Can't to like")
                }
            ).addDisposableTo(bag)
        
    }
    
    
//    var likeObservable : Observable <Bool>? {
//        
//        didSet {
//            likeObservable?
//                .flatMapLatest{ (likeStatus : Bool) -> Observable <Bool> in
//                    return self.albumApiService.getAlbumStatus(likeStatus)
//                }
//                .subscribe(onNext: { (like) in
//                    self.albumStatus.value = like
//                }
//            ).addDisposableTo(bag)
//            
//        }
//    }
}

