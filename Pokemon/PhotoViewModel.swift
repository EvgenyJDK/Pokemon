//
//  PhotoViewModel.swift
//  Pokemon
//
//  Created by Evgeny on 9/2/16.
//  Copyright © 2016 Evgeny. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

class PhotoViewModel {
    
    private let albumApiService = AlbumApiService()
    private let bag = DisposeBag()
    
    var albumDetails : Variable <Album> = Variable(Album())
//    var photo : Variable <[Photo]> = Variable([])
    var photoSection : Variable<[PhotoSection]> = Variable([])

    
    init (cellViewModel : CellViewModel) {

        
        self.albumDetails.value = cellViewModel.album
        self.albumDetails.asObservable()
            .flatMapLatest { (albumDetails : Album) -> Observable<[Photo]> in
            return self.albumApiService.getAlbumDetails(cellViewModel.album.albumId!)
        }
            .map { (photos : [Photo]) -> [PhotoSection] in
                return [PhotoSection(header : "Photo Collection" , items: photos)]
        }
            .subscribeNext { (photoSections : [PhotoSection]) in
            self.photoSection.value = photoSections
        }
        .addDisposableTo(bag)
    }
}

extension PhotoViewModel : IdentifiableType, Equatable {
    
    var identity : String {
        return "Photo"
    }
}

func ==(lhs: PhotoViewModel, rhs: PhotoViewModel) -> Bool {
    
    return true
}

