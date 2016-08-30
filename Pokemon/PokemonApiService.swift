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
                    pokeUrls.append(String (result["url"]!))
                }
                print (pokeUrls)
                return pokeUrls
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
                return ""
        }
    }

    func getPokemonDetails(pokemonUrl : String) -> Observable <[String]> {
        
        return  Alamofire.request(.GET, pokemonUrl)
            .rx_responseJSON()
            .map { (resp: NSHTTPURLResponse, json: AnyObject) -> [String] in
                
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
                        return []
                }
                
                print ("Type = \(typeName)")
                print ("Experience = \(experience)")
                print("Height = \(height)")
                print("Weight = \(weight)")
                print ("Ability = \(abilityName)")
                
                return []
        }
    }
}



