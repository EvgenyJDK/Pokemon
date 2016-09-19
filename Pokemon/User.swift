//
//  User.swift
//  Pokemon
//
//  Created by Evgeny on 9/1/16.
//  Copyright © 2016 Evgeny. All rights reserved.
//

import Foundation

class User : Equatable {
    
    var userId : Int?
    var name : String?
    var userName : String?
    var email : String?
    
}


func ==(lhs: User, rhs: User) -> Bool {
    return lhs.userId == rhs.userId &&
        lhs.name == rhs.name
}
