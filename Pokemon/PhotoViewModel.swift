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

class PhotoViewModel {
    
    private let albumApiService = AlbumApiService()
    private let bag = DisposeBag()
    
    var albumDetails : Variable <Album> = Variable(Album())
    var photo : Variable <[Photo]> = Variable([])

    init (cellViewModel : CellViewModel) {

        self.albumDetails.value = cellViewModel.album
        self.albumDetails.asObservable()
            .flatMapLatest { (albumDetails : Album) -> Observable<[Photo]> in
                return self.albumApiService.getAlbumDetails(cellViewModel.album.albumId!)
            }
            .subscribe(onNext: { (photo : [Photo]) in
                self.photo.value = photo
                }
            ).addDisposableTo(bag)
    }

}
    
