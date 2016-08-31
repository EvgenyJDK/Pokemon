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
    

    func getAllPokemonUrl () -> Observable <[String]> {

        let url = "http://pokeapi.co/api/v2/pokemon"
        let param = ["limit" : 5]
        
        return  Alamofire.request(.GET, url, parameters: param)
            .rx_responseJSON()
            .map { (resp: NSHTTPURLResponse, json: AnyObject) -> [String] in
                
                var pokemonUrls : [String] = []
                
                guard let resultUrl = json ["results"] as? [[String: AnyObject]]
//                    let pokemonName = json ["name"] as? String
                
                    else {
                        print("Error")
                        return pokemonUrls
                }
                for result in resultUrl {
                    pokemonUrls.append(String (result["url"]!))
                }
//                print (pokemonUrls)
                return pokemonUrls
        }
    }

    func getPokemonPreview () -> Observable <String> {
 
            let pokemonUrl = "http://pokeapi.co/api/v2/pokemon/1/"
        
        return  Alamofire.request(.GET, pokemonUrl)
            .rx_responseJSON()
            .map { (resp: NSHTTPURLResponse, json: AnyObject) -> String in
                
                guard let id = json ["id"] as? Int,
                 let name = json ["name"] as? String
                     else {
                        print ("Error data")
                        return ""
                }
                print (id)
                print (name)
                return name
        }
    }

    func getPokemonDetails(pokemonUrl : String) -> Observable <[String : String]> {
        
        return  Alamofire.request(.GET, pokemonUrl)
            .rx_responseJSON()
            .map { (resp: NSHTTPURLResponse, json: AnyObject) -> [String : String] in
                
                guard
                    
                    let types = json ["types"] as? [[String: AnyObject]],
                    let type = types [0] ["type"] as? [String: AnyObject],
                    let typeName = type ["name"] as? String,
                    
                    let experience = json ["base_experience"] as? Int,
                    let height = json ["height"] as? Int,
                    let weight = json ["weight"] as? Int,
                    
                    let abilities = json ["abilities"] as? [[String: AnyObject]],
                    let ability = abilities [0] ["ability"] as? [String: AnyObject],
                    let abilityName = ability ["name"] as? String
                    
                    else {
                        print ("Error Details")
                        return [:]
                }

                return ["typeName" : typeName, "Experience" : String(experience), "Height" : String(height),
                    "Weight" : String(weight), "Ability" : abilityName ]
        }
    }
}



