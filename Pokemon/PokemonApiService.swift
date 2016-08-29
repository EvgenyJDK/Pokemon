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

    
    func getAllPoke (data : String) -> Observable <[String]> {
        
        let url = "http://pokeapi.co/api/v2/pokemon"
        
        return  Alamofire.request(.POST, url)
            .rx_responseJSON()
            .map { (res: NSHTTPURLResponse, json: AnyObject) -> [String] in
                
                var pokeUrls : [String] = []
                
                guard let result = json ["result"] as? [[String: AnyObject]] else {
                    
                    return pokeUrls
                }
                return pokeUrls
        }
    }
}

