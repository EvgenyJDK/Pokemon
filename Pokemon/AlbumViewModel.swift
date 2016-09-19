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
import RxDataSources

class AlbumViewModel {
    
    var sections : Variable<[DataSection]> = Variable([])
    private let albumApiService = AlbumApiService()
    private let bag = DisposeBag()

    var photoViewModel : Variable<PhotoViewModel?> = Variable(nil)
    var cellViewModelList : Variable <[CellViewModel]> = Variable([])
 
    
    init () {
        
        albumApiService.getAllAlbums()
            .map { (allAlbums : [Album]) -> [CellViewModel] in
                return allAlbums.map { (album : Album) -> CellViewModel in
                    return CellViewModel(album : album)
                }
        }
            .subscribeNext { (cellViewModels : [CellViewModel]) in
            self.cellViewModelList.value = cellViewModels
        }
        .addDisposableTo(bag)
    }

    
    func initPhotoModelByRowIndex (rowIndex : Int) {
        self.photoViewModel.value = PhotoViewModel (cellViewModel : cellViewModelList.value[rowIndex])
    }

    
    func setAlbumStatusLike (rowIndex : Int, likeStatus : Bool) {
        AlbumStorage.setAlbumStatusLike(rowIndex+1, likeStatus: likeStatus)
    }
    
}


