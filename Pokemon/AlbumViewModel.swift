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
 

//    var likedAlbums : Variable <[LikedAlbumViewModel]> = Variable([])
 
    var likedAlbumViewModel : Variable<LikedAlbumViewModel?> = Variable(nil)
    
    func  getLikedAlbums(rowIndex : Int, likeStatus : Bool) {
        print(rowIndex)
        print (likeStatus)
//        print (likedAlbums)

        print ("MODEL before = \(self.albumList.value[rowIndex].title)")
        print ("MODEL before = \(self.albumList.value[rowIndex].like)")
//        self.likedAlbumViewModel.value = LikedAlbumViewModel(likedAlbum : albumList.value[rowIndex], likedStatus : likeStatus)
        
         self.likedAlbumViewModel.value = LikedAlbumViewModel(likedAlbum : albumList.value[rowIndex], likedStatus : likeStatus)
        
        print ("MODEL after = \(self.albumList.value[rowIndex].title)")
        print ("MODEL after = \(self.albumList.value[rowIndex].like)")
        

                print(albumList.value.count)
        
        for var i=0; i<100; i++ {
            print (i)
            print(albumList.value[i].like)
        }
        
        
//        print (self.albumList.value[1].like)
        
//        for var i=0; i<100; i++ {
//            print("\(self.albumList.value[i].like)")
//            if self.albumList.value[i].like {
//                print(self.albumList.value[i].title)
//                print(self.albumList.value[i].like)
//            }
//            
//        }
        

        
//        for val in albumList.value.count 
        
        
//        likedAlbumViewModel.likeObservable?.asObservable()
//            .subscribeNext{ (like :Bool) in
//                print ("SUBSCRIBE")
//            }
//            .addDisposableTo(bag)
  

        
        }
    }

