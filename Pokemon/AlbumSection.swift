//
//  AlbumSection.swift
//  Pokemon
//
//  Created by Evgeny on 9/20/16.
//  Copyright © 2016 Evgeny. All rights reserved.
//

import Foundation
import RxDataSources

struct AlbumSection {

    var header : String
    var items : [Item]
}


extension AlbumSection : AnimatableSectionModelType {
    
    typealias Item = CellViewModel
    
    var identity : String {
        return header
    }
    
    init (original: AlbumSection, items: [Item]) {
        self = original
        self.items = items
    }


}