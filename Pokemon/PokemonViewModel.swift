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

    var pokeObservable : Observable <[String]>? {
        
        didSet {
            pokeObservable!
                .subscribe(onNext: { (result : [String]) in
                    self.pokeNameList.value = result
                })
                
            .addDisposableTo(bag)
            }
    
//                .subscribeNext(onNext: (Self.poke) -> Void)
            
            
//            
//            pokeObservable
//                .flatMap{ (inputData : String) -> Observable <[String]?> in
//                    i
//                    guard true else {
//                        return Observable.just()
//                    }
//                    self.pokeName.value =  "New"
//                    return self.apiService.getAllPoke(inputData)
//                }
//
//                .subscribe(
//                    onNext: { text in
//                        
//                        self.pokeName.value = text
//                    },
//                    onError: { error in
//                        self.pokeName.value = "Response error"
//                    }
//                ).addDisposableTo(self.bag)
//        }

        
    }







// ПРИМЕР


//        didSet {
//            translationObservable!
//                .throttle(0.5, scheduler: MainScheduler.instance)
//                .flatMapLatest{ (inputData : String) -> Observable <String> in
//                    
//                    guard inputData.characters.count > 2 else {
//                        return Observable.just("")
//                    }
//                    
//                    self.activityView.value =  true
//                    return self.apiService.translateDataViaYandex(inputData)
//                }
//                .subscribe(
//                    onNext: { text in
//                        
//                        self.translatedText.value = text
//                        self.activityView.value =  false
//                    },
//                    onError: { error in
//                        self.translatedText.value = "Response error"
//                        self.activityView.value =  false
//                    }
//                ).addDisposableTo(self.bag)


    
    
    
}