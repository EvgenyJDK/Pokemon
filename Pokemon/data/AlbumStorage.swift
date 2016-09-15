//
//  AlbumStorage.swift
//  Pokemon
//
//  Created by Evgeny on 9/12/16.
//  Copyright © 2016 Evgeny. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class AlbumStorage {
    
    static var storageLikedAlbumId : Variable < Set<Int> > = Variable ([])
    
    
    static func setAlbumStatusLike(albumId : Int, likeStatus : Bool) {
        
        var alb : Set <Int> = AlbumStorage.storageLikedAlbumId.value
        
        if likeStatus {
            alb.insert(albumId)
        }
        else {
            alb.remove(albumId)
        }
        
        print(alb)
        AlbumStorage.storageLikedAlbumId.value = alb
        
    }

    
    
}