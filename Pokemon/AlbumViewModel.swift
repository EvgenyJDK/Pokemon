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
    
    let albumList : Variable <[String]> = Variable([""])
    
    private let bag = DisposeBag()
    
    init () {
            
        albumApiService.getAllAlbums()
            .subscribe(onNext: { result in
                self.albumList.value = result
                print (self.albumList.value)
                },
                onError: { error in
                    self.albumList.value = []
            }).addDisposableTo(bag)
        
    }
}