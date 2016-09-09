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
    var likedAlbumViewModel : Variable<LikedAlbumViewModel?> = Variable(nil)
    
//    var storageAlbumViewModel : Variable <StorageAlbumViewModel?> = Variable(nil)
        var storageAlbumViewModel : Variable <[Album]> = Variable([])

    init () {
        
        print("SECOND")
        
        albumApiService.getAllAlbums()
            .subscribe(onNext: { resultAlbum in
                self.albumList.value = resultAlbum
                self.storageAlbumViewModel.value = resultAlbum
//                self.storageAlbumViewModel.value[2].like = true
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

    
    func saveAlbumModelToStorage () {
        print ("SAVE = \(albumList.value.count)")
        StorageAlbumViewModel.storageAlbumViewModel.value = self.albumList.value
    }

    
    
    func  saveAlbumStatusLike(rowIndex : Int, likeStatus : Bool) {
        print(rowIndex)
        print (likeStatus)

        print ("MODEL before = \(self.albumList.value[rowIndex].title)")
        print ("MODEL before = \(self.albumList.value[rowIndex].like)")
        print ("MODEL STORAGE before = \(self.storageAlbumViewModel.value[rowIndex].like)")
        
         self.likedAlbumViewModel.value = LikedAlbumViewModel(likedAlbum : albumList.value[rowIndex], likedStatus : likeStatus)
        
        print ("MODEL after = \(self.albumList.value[rowIndex].title)")
        print ("MODEL after = \(self.albumList.value[rowIndex].like)")
        
//        StorageAlbumViewModel.storageAlbumViewModel.value![1].like = self.albumList.value[rowIndex].like
        print ("MODEL STORAGE after = \(self.storageAlbumViewModel.value[rowIndex].like)")
        print(storageAlbumViewModel.value.count)
        
        for var i=0; i<100; i++ {
            print (i)
            print(albumList.value[i].like)
//            print (self.storageAlbumViewModel.value)
        }
       
        
//        likedAlbumViewModel.likeObservable?.asObservable()
//            .subscribeNext{ (like :Bool) in
//                print ("SUBSCRIBE")
//            }
//            .addDisposableTo(bag)
   
    }
}

