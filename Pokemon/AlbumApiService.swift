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
    
    func getAllAlbums () -> Observable<[Album]> {

        let pathAlbums = NSBundle.mainBundle().pathForResource("albums", ofType: "json")
        let dataAlbums = NSData(contentsOfFile: pathAlbums!)
        let jsonAlbums = try!NSJSONSerialization.JSONObjectWithData(dataAlbums!, options: [])
        
        var albumList : [Album] = []
        
        for anItem in jsonAlbums as! [Dictionary <String, AnyObject>] {
            
            let album = Album()
            let albumId = anItem ["id"] as! Int
            let title = anItem ["title"] as! String
            let userId = anItem ["userId"] as! Int
            
            album.albumId = albumId
            album.title = title
            album.userId = userId
            album.like = false
            albumList.append(album)
        }
        
        return Observable.just(albumList).flatMap { (value) -> Observable<[Album]> in
            
            return Observable.create({ (observer) -> Disposable in
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), {
                    observer.onNext(value)
                    observer.onCompleted()
                });
                
                return NopDisposable.instance
            })
        }
    }
    
    
    func getUserName () -> Observable<[User]> {
        
        let pathUsers = NSBundle.mainBundle().pathForResource("users", ofType: "json")
        let dataUsers = NSData(contentsOfFile: pathUsers!)
        let jsonUsers = try!NSJSONSerialization.JSONObjectWithData(dataUsers!, options: [])
        
        var userList : [User] = []
        
        for anItem in jsonUsers as! [Dictionary <String, AnyObject>] {
            
            let user = User()
            let userId = anItem["id"] as? Int
            let userName = anItem["username"] as? String
            
            user.userId = userId
            user.name = userName
            userList.append(user)
        }
        return Observable.just(userList)       
    }
    
    
    func getAlbumDetails (albumId : Int) -> Observable<[Photo]> {
        
        let pathPhotos = NSBundle.mainBundle().pathForResource("photos", ofType: "json")
        let dataPhotos = NSData(contentsOfFile: pathPhotos!)
        let jsonPhotos = try!NSJSONSerialization.JSONObjectWithData(dataPhotos!, options: [])
        
        var albumDetails : [Photo] = []
        
        for anItem in jsonPhotos as! [Dictionary <String, AnyObject>] {
            
            let photo = Photo()
            let photoAlbumId = anItem ["albumId"] as? Int
            let photoUrl = anItem["url"] as? String
            let photoTitle = anItem ["title"] as? String
            
            if photoAlbumId == albumId {
                photo.url = photoUrl
                photo.title = photoTitle
                albumDetails.append(photo)}
            else { print ("Album doesn't match with request")}
        }
        return Observable.just(albumDetails)
    }

 
    func changeAlbumStatusLike(albumId : Int, likeStatus : Bool) {
        
        var alb : Set <Int> = AlbumStorage.storageLikedAlbumId.value
        
        if likeStatus {
            alb.insert(albumId)
        }
        else {
            alb.remove(albumId)
        }
        AlbumStorage.storageLikedAlbumId.value = alb
    }

    
    func getLikedAlbums (likedAlbList : Set <Int>) -> Observable<[Album]> {
        
        return self.getAllAlbums()
            .map{ (allAlbums : [Album]) -> [Album] in
                return allAlbums.filter { (album) -> Bool in
                    return likedAlbList.contains(album.albumId!)
                }
        }
    }
    

    
    func getUsersByAlbum (albums : [Album]) -> Observable<[User]> {
        
        return albums.map{ (album : Album) -> Observable<User> in
            return getUserNameByAlbum(album)
            }.combineLatest{ (users : [User]) -> [User] in
            return users
        }
    }
 
    
    func getUserNameByAlbum (album : Album) -> Observable<User> {
        
//        return getUserName().map{ (users : [User]) -> User in
//            return (users.filter{ (user : User) -> Bool in
//                return user.userId == album.userId
//            }
//            )
//        }
        return album as! Observable<User>
    }
    

    
/*
    func getLikedUserName (likedUserId : Set <Int>) -> Observable<[User]> {
     
        print("getLikedUserName")
     
        return self.getUserName()
            .map{ (allUsers : [User]) -> [User] in
                print("COUNT = \(allUsers.count)")
                return allUsers.filter{ (user) -> Bool in
                    print("username = \(user.userName)")
                    return likedUserId.contains(user.userId!)
                }
        }
    }
*/


    func getLikedUserName (likedUserId : Int) -> Observable<[User]> {

        return self.getUserName()
            .map{ (allUsers : [User]) -> [User] in
                print("COUNT = \(allUsers.count)")
                print("VALUE = \(allUsers[1].email)")
            return allUsers
//                .filter{ (user) -> Bool in
//                return likedUserId == user.userId!
                
//            }
        }
    }

 
}




/*            .subscribeNext { (allAlbums : [Album]) in
                allAlbumList = allAlbums
                for album in allAlbumList {
                    if likedAlbList.contains(album.albumId!) {
                        likedAlbumList.append(album)
                    }
                }
        }
*/

    





