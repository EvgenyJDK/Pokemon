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

        albumApiService.getAllAlbums()
            .subscribe(onNext: { resultAlbum in
                self.albumList.value = resultAlbum
//                self.storageAlbumViewModel.value = resultAlbum
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
  
    
    var likedAlbumId : Variable <Int> = Variable(0)
    var likeAlbId : Variable <Int> = Variable(0)
    var storageLikedAlbumId : Variable <[Int]> = Variable ([])

    func changeAlbumStatusLike (rowIndex : Int, likeStatus : Bool) {
        
//        print ("CHANGE ROW = \(rowIndex)")
//        print ("CHANGE ALBUMID = \(self.albumList.value[rowIndex].albumId)")
        
        self.likeAlbId.value = self.albumList.value[rowIndex].albumId!
//        print ("CHANGE likeAlbId.value = \(self.likeAlbId.value)")
        
        self.likeAlbId.asObservable()
            .flatMapLatest { (likeAlbId : Int) -> Observable<Int> in
                return self.albumApiService.changeAlbumStatusLike(self.likeAlbId.value, likeStatus : likeStatus )
            }
            .subscribe(onNext: { (likedAlbId : Int) in
                self.likedAlbumId.value = likedAlbId
//                print("likedAlbumId.value = \(self.likedAlbumId.value)")
                }, onError: { (ErrorType) in
                    print ("Can't to like")
                }
            ).addDisposableTo(bag)
    }
    
    
    func saveToAlbumStorage (liked : Bool, albumId : Int) {
        
        let a = self.likedAlbumId.value
        print("a = \(a)")

        print("albumId = \(albumId)")
        if liked {
            if albumId != 0 {
                StorageAlbumViewModel.storageLikedAlbumId.value.append(albumId)
                print ("storageLikedAlbumId AFTER = \(StorageAlbumViewModel.storageLikedAlbumId.value)")
            }
            else {
            }
        }
        
        else {
            
            print(liked)
            print("a TO REMOVE = \(a)")
            print("albumId  TO REMOVE = \(albumId)")
            
            if a != 0 {
                print ("TO REMOVE = \(StorageAlbumViewModel.storageLikedAlbumId.value.indexOf(albumId)!)")
                StorageAlbumViewModel.storageLikedAlbumId.value.removeAtIndex(StorageAlbumViewModel.storageLikedAlbumId.value.indexOf(albumId)!)
                
            }
            print ("storageLikedAlbumId AFTER = \(StorageAlbumViewModel.storageLikedAlbumId.value)")
        }
        print ("storageLikedAlbumId AFTER = \(StorageAlbumViewModel.storageLikedAlbumId.value)")
    }
   
   
    func saveAlbumStatusLike (rowIndex : Int, likeStatus : Bool) {
        self.likedAlbumViewModel.value = LikedAlbumViewModel(likedAlbum : albumList.value[rowIndex], likedStatus : likeStatus)
        print("STATUS = \(likedAlbumViewModel.value)")
        
//        self.likedAlbumIdArray.value = LikedAlbumViewModel(likedAlbum : albumList.value[rowIndex], likedStatus : likeStatus)
//       self.likedAlbumViewModel.value = LikedAlbumViewModel(likedAlbumId : rowIndex, likedStatus : likeStatus)
    }
    
}







/*    func changeAlbumStatusLike (rowIndex : Int, likeStatus : Bool) {
 
 self.likeAlbId.value = rowIndex
 self.likeAlbId.asObservable()
 
 .flatMapLatest { (likedAlbumId : Int) -> Observable<[Int]> in
 return self.albumApiService.changeAlbumStatusLike(rowIndex, likeStatus : likeStatus )
 }
 .subscribe(onNext: { (likedAlbId : [Int]) in
 self.likedAlbumId.value = likedAlbId
 print("likedAlbumId.value = \(self.likedAlbumId.value)")
 StorageAlbumViewModel.storageLikedAlbumId.value = self.likedAlbumId.value
 print ("STORAGE = \(StorageAlbumViewModel.storageLikedAlbumId.value)")
 }, onError: { (ErrorType) in
 print ("Can't to like")
 }
 ).addDisposableTo(bag)
 
 print ("STORAGE = \(StorageAlbumViewModel.storageLikedAlbumId.value)")
 }
 */







/*
    func  saveAlbumStatusLike(rowIndex : Int, likeStatus : Bool) {

        print ("MODEL before = \(self.albumList.value[rowIndex].title)")
        print ("MODEL before = \(self.albumList.value[rowIndex].like)")
//        print ("MODEL STORAGE before = \(self.storageAlbumViewModel.value[rowIndex].like)")
        
         self.likedAlbumViewModel.value = LikedAlbumViewModel(likedAlbum : albumList.value[rowIndex], likedStatus : likeStatus)
        
        print ("MODEL after = \(self.albumList.value[rowIndex].title)")
        print ("MODEL after = \(self.albumList.value[rowIndex].like)")
        
//        StorageAlbumViewModel.storageAlbumViewModel.value![1].like = self.albumList.value[rowIndex].like
//        print ("MODEL STORAGE after = \(self.storageAlbumViewModel.value[rowIndex].like)")
        print(storageAlbumViewModel.value.count)
    }
*/
    
    
    
        
        
//        for var i=0; i<100; i++ {
//            print (i)
//            print(albumList.value[i].like)
//            print (self.storageAlbumViewModel.value)
//        }
       
 



