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
//    private let photoViewModel = PhotoViewModel()
    private let bag = DisposeBag()

    var likedAlbumList : Variable <[Album]> = Variable([])
    var likedUserNameList : Variable <[User]> = Variable([])
    
    var likedCellViewModelList : Variable <[CellViewModel]> = Variable([])
    var photoViewModel : Variable <PhotoViewModel?> = Variable(nil)
    
    
    var likedUserName : Variable<User?> = Variable(nil)
    var likedAlbumOne : Variable<Album?> = Variable(nil)

    
    init () {
 
        AlbumStorage.storageLikedAlbumId.asObservable()
            .flatMap { (likedAlbumId : Set<Int>) -> Observable<[Album]> in
                return self.albumApiService.getLikedAlbums(likedAlbumId)
                
            }
            .map{ (albums : [Album]) -> [CellViewModel] in
                return albums.map{ (album : Album) -> CellViewModel in
                    
                    print(album.title)
                    return CellViewModel (album : album)
                }
            }
            .subscribeNext { [unowned self] (cells: [CellViewModel]) in
                self.likedCellViewModelList.value = cells
        }
       
        
//        AlbumStorage.storageLikedAlbumId.asObservable()
//            .flatMap { (likedAlbumId : Set<Int>) -> Observable<[Album]> in
//                //                print("INIT LIKED = \(likedAlbumId)")
//                return self.albumApiService.getLikedAlbums(likedAlbumId)
//                    .map{ (albums : [Album]) -> [CellViewModel] in
//                        return albums.map{ (album : Album) -> CellViewModel in
//                            print(album.title)
//                            return CellViewModel (album : album)
//                        }
//                }
//                    .subscribeNext{ [unowned self](cellViewModels : [CellViewModel]) in
//                    self.likedCellViewModelList.value = cellViewModels
//                }
//                
//                
//    
//        }
        
    }
    

    
//    init () {
//        
//        AlbumStorage.storageLikedAlbumId.asObservable()
//            .flatMap{ (albumId : Set<Int>) -> Observable<[Album]> in
//                self.albumApiService.getLikedAlbums(albumId)
//            }
//            .subscribeNext { (likedAlbums :[Album]) in
//                print("Hi!!!!")
//                self.likedAlbumList.value = likedAlbums
//                print(likedAlbums)
//
////                self.albumApiService.getUsersByAlbum(likedAlbums)
////                    .subscribeNext({ (users : [User]) in
////                    self.likedUserNameList.value = users
////                         print("LIKED INIT = \(self.likedUserNameList.value)")
////                })
//            }
//            .addDisposableTo(bag)
//    }

    
    func initPhotoModelByRowIndex (rowIndex : Int) {
        self.photoViewModel.value = PhotoViewModel (cellViewModel : likedCellViewModelList.value[rowIndex])
        //        self.photoViewModel.value = PhotoViewModel(album : albumList.value[rowIndex])
        //        print (self.photoViewModel.value)
    }

    
    
    func getUserNameByAlbum (likedAlbum : Album) {
        
        albumApiService.getUserNameByAlbum(likedAlbum)
            .subscribeNext{ (user : User) in
                print("GET ~~~~~~ = \(user.name)")
                self.likedUserName.value = user
            }
            .addDisposableTo(bag)
    }
    
    
    func setAlbumStatusLike (rowIndex : Int, likeStatus : Bool) {
//        print("LIKE MODEL = \(rowIndex)")
//        print("LIKE MODEL = \(likeStatus)")
        AlbumStorage.setAlbumStatusLike(rowIndex+1, likeStatus: likeStatus)
    }

    
//    func getLikedAlbum () {
//        AlbumStorage.storageLikedAlbumId.asObservable()
//            .flatMap { (albumIds : Set<Int>) -> Observable<Album> in
//                self.albumApiService.getLikedAlbum(albumIds)
//            }
//            .subscribeNext { (likedAlbum : Album) in
//                self.likedAlbumOne.value = likedAlbum
//        }
//    }

}





