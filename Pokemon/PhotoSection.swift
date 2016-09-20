//
//  PhotoSection.swift
//  Pokemon
//
//  Created by Evgeny on 9/20/16.
//  Copyright © 2016 Evgeny. All rights reserved.
//

import Foundation
import RxDataSources

struct PhotoSection {
    
    var header : String
    var items : [Item]
 
}

extension PhotoSection : AnimatableSectionModelType {
    
    typealias Item = Photo
    
    var identity : String {
        return header
    }
    
    init (original: PhotoSection, items: [Item]) {
        self = original
        self.items = items
    }

    
}