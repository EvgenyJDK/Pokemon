//
//  PokemonApiService.swift
//  Pokemon
//
//  Created by Evgeny on 8/29/16.
//  Copyright © 2016 Evgeny. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import RxAlamofire
import RxCocoa
import RxSwift

class PokemonApiService {

    
    func getAllPoke (inputData : String) -> Observable <String> {
        
        let url = "http://pokeapi.co/api/v2/pokemon/1/"

        return  Alamofire.request(.POST, url)
            .rx_responseJSON()
            .map { (res: NSHTTPURLResponse, json: AnyObject) -> String in
                
             
               
                }
                return "hello" as?  String
        }
    }

