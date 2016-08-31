//
//  AlbumApiService.swift
//  Pokemon
//
//  Created by Evgeny on 8/31/16.
//  Copyright © 2016 Evgeny. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import RxAlamofire
import RxCocoa
import RxSwift

class AlbumApiService {
  
    
    //    let path = NSBundle.mainBundle().pathForResource("photos", ofType: "json")
    //    let data = NSData(contentsOfFile: path!)
    //    let json = NSJSONSerialization.JSONObjectWithData(data!, options: [])

    //    let path = NSBundle.mainBundle().pathForResource("user", ofType: "json")
    //    let data = NSData(contentsOfFile: path!)
    //    let json = NSJSONSerialization.JSONObjectWithData(data!, options: [])

   
    func getAllAlbums () -> Observable<[String]> {
        
        
        let path = NSBundle.mainBundle().pathForResource("albums", ofType: "json")
        let data = NSData(contentsOfFile: path!)
        let json = try!NSJSONSerialization.JSONObjectWithData(data!, options: [])
        
        print (json)
        
        var albumsTitle : [String] = []
        
        for anItem in json as! [Dictionary <String, AnyObject>] {
            
            //        let userId = anItem["id"] as! Int
            let title = anItem["title"] as! String
            
            //            pokemonUrls.append(String (result["url"]!))
            
            albumsTitle.append(title)
        }
        print (albumsTitle)
        return Observable.just(albumsTitle)
    }
}




//    func getAllAlbums () -> Observable <String> {
//
//        var albums : [String] = []
//
//        let path = NSBundle.mainBundle().pathForResource("albums", ofType: "json")
//        let data = NSData(contentsOfFile: path!)
//        let json = try!NSJSONSerialization.JSONObjectWithData(data!, options: [])
//
//        guard let result = json ["title"] as? String else {
//            print ("Error")
////            return ""
//        }
//
//       print (result)
//        return result
//    }


