//
//  StorageAlbumViewModel.swift
//  Pokemon
//
//  Created by Evgeny on 9/8/16.
//  Copyright © 2016 Evgeny. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class StorageAlbumViewModel {
    
//    static var storageAlbumViewModel : Variable<[LikedAlbumViewModel]?> = Variable([])
    static var storageAlbumViewModel : Variable<[Album]?> = Variable([])
    
    static var storageLikedAlbumViewModel : Variable<[Album?]> = Variable([])
    
//    private func filter () {
//    
//    StorageAlbumViewModel.storageAlbumViewModel.asObservable()
//        .filter({ (<#[Album?]#>) -> Bool in
//            <#code#>
//        })
//        .map { (_: [Album?]) -> Observable<Album> in
//            
//        }
//    
//    }
    
}