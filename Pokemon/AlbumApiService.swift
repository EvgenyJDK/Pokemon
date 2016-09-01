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

   
    func getAllAlbums () -> Observable<[Album]> {
        
        
        let path = NSBundle.mainBundle().pathForResource("albums", ofType: "json")
        let data = NSData(contentsOfFile: path!)
        let json = try!NSJSONSerialization.JSONObjectWithData(data!, options: [])
        
        print (json)
        
        var albumsTitle : [String] = []

        var albumList : [Album] = []
        
        for anItem in json as! [Dictionary <String, AnyObject>] {
            
            var album = Album()
            let albumId = anItem["id"] as! Int
            let title = anItem["title"] as! String
            let userId = anItem ["userId"] as! Int
            
            album.albumId = albumId
            album.title = title
            album.userId = String(userId)

//            print(albumList)
            albumList.append(album)
//            print (albumList[0].title)
            albumsTitle.append(title)
        }
        
//        print (albumList[3].title)
        
//        print (albumsTitle)
//        return Observable.just(albumsTitle)

        return Observable.just(albumList)
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


