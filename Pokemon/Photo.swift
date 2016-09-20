//
//  Photo.swift
//  Pokemon
//
//  Created by Evgeny on 9/2/16.
//  Copyright © 2016 Evgeny. All rights reserved.
//

import Foundation
import RxDataSources

class Photo {
    
    var albumId : Int?
    var title : String?
    var url : String?

}

extension Photo : IdentifiableType, Equatable {
    
    var identity : String {
        return "Photo"
    }
}

func ==(lhs: Photo, rhs: Photo) -> Bool {
    
//    return true
    return lhs.albumId == rhs.albumId &&
        lhs.url == rhs.url
    
}
