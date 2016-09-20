//
//  Album.swift
//  Pokemon
//
//  Created by Evgeny on 9/1/16.
//  Copyright © 2016 Evgeny. All rights reserved.
//

import Foundation

class Album : Equatable {
    
    var albumId : Int?
    var title : String?
    var userId : Int?
}


func == (lhs: Album, rhs: Album) -> Bool {
    return lhs.albumId != rhs.albumId
}
