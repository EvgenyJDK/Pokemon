//
//  PokemonViewModel.swift
//  Pokemon
//
//  Created by Evgeny on 8/29/16.
//  Copyright © 2016 Evgeny. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


class PokemonViewModel {
    
    private let apiService = PokemonApiService ()
    
    let pokeName : Variable <String> = Variable ("")
    let pokeNameList : Variable <[String]> = Variable ([""])

    private let bag = DisposeBag ()
    
    var pokeObservable : Observable <String>? {
        
        didSet {
            apiService.getNamePoke()
                .subscribe(onNext: { (result : String) in
                    self.pokeName.value = result
                    },
                    onError: { error in
                        self.pokeName.value = "Not found"
                    }
                ).addDisposableTo(bag)
        }
    }
}