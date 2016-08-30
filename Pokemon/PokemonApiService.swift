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

        let url = "http://pokeapi.co/api/v2/pokemon"
        
        return  Alamofire.request(.GET, url)
            .rx_responseJSON()
            .map { (resp: NSHTTPURLResponse, json: AnyObject) -> [String] in
                
                var pokeUrls : [String] = []
                
                guard let resultUrl = json ["results"] as? [[String: AnyObject]]
                    else {
                        print("Error")
                        return pokeUrls
                }
                for result in resultUrl {
                    pokeUrls.append(String (result["url"]))
                }
                return pokeUrls
        }
    }
    
    
    func getNameIdPoke () -> Observable <[String]> {
        
        let url = "http://pokeapi.co/api/v2/pokemon/1/"
        
        return  Alamofire.request(.GET, url)
            .rx_responseJSON()
            .map { (resp: NSHTTPURLResponse, json: AnyObject) -> [String] in
                
                guard let name = json ["name"] as? String,
                let weight = json ["weight"] as? Int
                    else {
                        print ("Error data")
                        return []
                }
                print(name)
                print (weight)
                return []
        }
    }
    
    func getNamePoke () -> Observable <String> {

        let url = "http://pokeapi.co/api/v2/pokemon/1/"
        
        return  Alamofire.request(.GET, url)
            .rx_responseJSON()
            .map { (resp: NSHTTPURLResponse, json: AnyObject) -> String in
                
                guard let name = json ["name"] as? String
                    else {
                        print ("Error data")
                        return ""
                }
                print(name)
                return name
        }
    }

    
}


//guard let weight = json ["weight"] as? Int
//    else {
//        print ("Weight Error")
//        return nil
//}
//print (weight)
//return weight
//}




//         guard let det = json ["forms"] as? [[String: AnyObject]],
//                let name = det.first! ["name"] as? String




