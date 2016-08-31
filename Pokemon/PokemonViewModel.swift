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
    
    let pokemonName : Variable <String> = Variable ("")
    let pokemonNameList : Variable <[String]> = Variable ([""])
    

    private let bag = DisposeBag ()
    
    var pokemonObservable : Observable <String>? {
        
        didSet {
            apiService.getPokemonPreview()
                .subscribe(onNext: { (result : String) in
                    self.pokemonName.value = result
                    },
                    onError: { error in
                        self.pokemonName.value = "Not found"
                    }
                ).addDisposableTo(bag)
        }
    }
}