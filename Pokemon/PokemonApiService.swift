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

    
//    func getAllPoke () -> Void {
    func getAllPoke () -> Observable <[String]> {
        
        print ("in Method")
        
        let url = "http://pokeapi.co/api/v2/pokemon"
        
        return  Alamofire.request(.POST, url)
            .rx_responseJSON()
            .map { (resp: NSHTTPURLResponse, json: AnyObject) -> [String] in
                
                var pokeUrls : [String] = []
                
                //                guard let count = json["count"] as? Int
                guard let resultUrl = json ["results"] as? [[String: AnyObject]]
                    
                    
                    //                guard let result = json ["results"] as? [[String: AnyObject]],
                    //                    let name = result.first?["name"] as? String
                    ////                guard let name = json ["name"] as? String
                    else {
                        print("Error")
                        return pokeUrls
                }

                for result in resultUrl {
                    
                    print ("Work")
                    //                print (count)
                    
                    pokeUrls.append(String (result["url"]))
                    print ("\(pokeUrls)")
                    print (pokeUrls)
                    

                }
                return pokeUrls
        }
    }
}


