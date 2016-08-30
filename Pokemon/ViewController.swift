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
    
  
 
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var resultField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
   apiService.getAllPoke()
    .subscribe(onNext: { result in
            print ("Hello")
            })
        
//        pokeViewModel.pokeObservable = searchField.rx_text.asObservable()
//        
//        pokeViewModel.pokeName.asObservable()
//            .bindTo(resultField.rx_text)
//            .addDisposableTo(bag)
        
        
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

