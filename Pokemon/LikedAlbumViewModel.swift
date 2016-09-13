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
    
//    let albumStatus : Variable<Bool> = Variable(false)
//
//    var albumDetails : Variable <Album> = Variable(Album())
//    var likedAlbums : Variable <Album?> = Variable(nil)
//
//    var likedAlbumId : Variable <[Int]> = Variable([])
//    var likeAlbId : Variable <Int> = Variable(0)
    

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
//                
//            }
//            .subscribeNext({ (users : [User]) in
//                
//            })
            .subscribeNext { (likedAlbums :[Album]) in
                self.likedAlbumList.value = likedAlbums
        }
        .addDisposableTo(bag)
        
        
        
        //                self.albumApiService.getLikedUserName(2)
        //                    .subscribe(onNext: { (likedUsers : [User]) in
        //                    self.likedUserNameList.value = likedUsers
        //                    print("USERNAME = \(self.likedUserNameList.value[0].userName)")
        //                    }, onError: { (ErrorType) in
        //
        //                        })
        
       
        
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



/*        albumApiService.getLikedAlbums(likedAlbList)
            .subscribe(onNext: { (resultLikedAlbums : [Album]) in
            self.likedAlbumList.value = resultLikedAlbums
            },
            onError: { (ErrorType) in
            print ("Error")
            }
        ).addDisposableTo(bag)          */








//   init (likedAlbum : Album, likedStatus : Bool) {
//    
////        print ("LIKEDALBUM")
////        print (likedAlbum.albumId!)
////        print(likedStatus)
// 
////    self.albumDetails.value = likedAlbumId
////    self.albumDetails.asObservable()
////            .flatMapLatest { (albumDetails : Album) -> Observable<[Int]> in
////                return self.albumApiService.saveAlbumStatus(likedAlbum, likeStatus : likedStatus )
////    }
//
//    
//    self.likeAlbId.value = likedAlbum.albumId!
//        self.likeAlbId.asObservable()
//            
//            .flatMapLatest { (likedAlbumId : Int) -> Observable<[Int]> in
//                return self.albumApiService.saveAlbumStatus(likedAlbum, likeStatus : likedStatus )
//            }
//            .subscribe(onNext: { (likedAlbId : [Int]) in
//                self.likedAlbumId.value = likedAlbId
////                print("LIKE = \(self.likedAlbumId.value)")
//                StorageAlbumViewModel.storageLikedAlbumId.value = self.likedAlbumId.value
////                print (StorageAlbumViewModel.storageLikedAlbumId.value)
//                }, onError: { (ErrorType) in
//                    print ("Can't to like")
//                }
//    
//    
//                
////            .flatMapLatest { (albumDetails : Album) -> Observable<Album> in
////                return self.albumApiService.saveAlbumStatus(likedAlbum, likeStatus : likedStatus )
////            }
////            .subscribe(onNext: { (likedAlbums : Album) in
////
////                self.likedAlbums.value = likedAlbums
////                print ("~~~~~~~~~~~~~~~~~~~~~~~~~~")
////                print(self.likedAlbums.value?.title)
////                print(self.likedAlbums.value?.like)
////                },
////                onError: { (ErrorType) in
////                    print ("Can't to like")
////                }
//
//                
//                
//                
//            ).addDisposableTo(bag)
//    }

    
    
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



