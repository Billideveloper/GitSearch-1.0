//
//  User.swift
//  GitSearch 1.0
//
//  Created by Ravi Thakur on 18/10/20.
//

import Foundation
import UIKit

struct SearchedResults: Decodable{
    
    var total_count: Int
    var items: [Users]
}

struct Users: Decodable {

    var login: String
    var avatar_url: String
    
}

struct Userinfo: Decodable {
    
    var name: String
    var avatar_url: String
    var bio: String
    var followers_url: String
    var location: String
    
    
}

struct Followers: Decodable {
    
    var avatar_url: String
    var login: String
    
}
