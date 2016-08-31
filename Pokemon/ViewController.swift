//
//  ViewController.swift
//  Pokemon
//
//  Created by Evgeny on 8/29/16.
//  Copyright © 2016 Evgeny. All rights reserved.
//

import UIKit
import Foundation
import RxSwift
import RxCocoa


class ViewController: UIViewController {

    private let pokemonViewModel = PokemonViewModel()
    private let bag = DisposeBag()
   
    private let apiService = PokemonApiService()
    let pokemonUrl = "http://pokeapi.co/api/v2/pokemon/1/"
    var urls : [String : String] = [:]
 
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var resultField: UITextField!
    
    @IBOutlet weak var resultIdField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemonViewModel.pokemonObservable = searchField.rx_text.asObservable()
        
//        pokemonViewModel.pokemonName.asObservable()
//            .bindTo(resultField.rx_text)
//            .addDisposableTo(bag)
        
        pokemonViewModel.pokemonName.asObservable()
            .subscribeNext { [weak self] (name : String) in
            self!.resultField.text = name
        }
        
        
        //        dictionaryModel.translatedText.asObservable()
        //            .subscribeNext { [weak self] (text : String) -> Void in
        //                self!.outputData.text = text
        //            }
        //            .addDisposableTo(bag)
        
        
        apiService.getPokemonDetails(pokemonUrl)
            .subscribe(onNext: { result in

                self.urls = result
                print (self.urls)
                print (self.urls["Weight"]!)
                
            })
        
        apiService.getAllPokemonUrl()
        .subscribe(onNext: { result in
           
            print ("result")
            print ("resultList of Urls = \(result)")
            
            })
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

