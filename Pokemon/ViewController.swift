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

    private let pokeViewModel = PokemonViewModel()
    private let bag = DisposeBag()
   
    private let apiService = PokemonApiService()
    let pokemonUrl = "http://pokeapi.co/api/v2/pokemon/1/"
    var urls : [String] = []
 
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var resultField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokeViewModel.pokeObservable = searchField.rx_text.asObservable()
        
        pokeViewModel.pokeName.asObservable()
            .bindTo(resultField.rx_text)
            .addDisposableTo(bag)
        
        apiService.getPokemonDetails(pokemonUrl)
            .subscribe(onNext: { result in

                self.urls = result
                print (self.urls)
                
            })
        
        apiService.getAllPokemonUrl()
        .subscribe(onNext: { result in
           
            print ("result")
            print ("result = \(result)")
            
            })
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

