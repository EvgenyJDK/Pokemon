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
    
    let albumList : Variable <[Album]> = Variable([])
    let userList : Variable <[User]> = Variable([])
    
    
    
//    let albumsPhotoImageLink : Variable <[Album]> = Variable([])
//    let userList : Variable <[User]> = Variable([])

    
    
    
    
}