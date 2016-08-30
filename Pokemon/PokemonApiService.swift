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

    
    func getAllPoke () -> Observable <[String]> {
        
        print ("in Method")
        
        let url = "http://pokeapi.co/api/v2/pokemon"
        
        return  Alamofire.request(.GET, url)
            .rx_responseJSON()
            .map { (resp: NSHTTPURLResponse, json: AnyObject) -> [String] in
                
                print ("after request")
                
                var pokeUrls : [String] = []
                
                guard let result = json ["result"] as? [[String: AnyObject]],
                let name = result.first!["name"] as! [[String: AnyObject]]!	else {
                    
                    
                    print("after request")
                    print ("\(pokeUrls)")
                    print (pokeUrls)
                    return pokeUrls
 
                    
                }

                print ("\(pokeUrls)")
                print (pokeUrls)
                return pokeUrls
        }
    }
}

