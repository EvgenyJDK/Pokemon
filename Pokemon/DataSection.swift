//
//  DataSection.swift
//  Pokemon
//
//  Created by Evgeny on 9/19/16.
//  Copyright © 2016 Evgeny. All rights reserved.
//

import Foundation
import RxDataSources

struct DataSection {
    
    var header : String
    var items : [Item]
  }


extension DataSection : AnimatableSectionModelType {
        
        typealias Item = CellViewModel
        
        var identify : String {
            return header
        }

        init (original: DataSection, items: [Item]) {
            self = original
            self.items = items
        }

    
}
