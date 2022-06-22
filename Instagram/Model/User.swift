//
//  User.swift
//  Instagram
//
//  Created by Omar Ahmed on 30/05/2022.
//

import Foundation
import Firebase

struct User {
    let email: String
    let username: String
    let uid: String
    let fullname: String
    let profileImageUrl: String
    var stats : UserStats!
    var isFollowed = false
    var isCurrentUser : Bool {return Auth.auth().currentUser?.uid == uid}
    
    init(dictionary:[String:Any]){
        self.email = dictionary["email"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.stats = UserStats(followers: 0, following: 0,posts: 0)
    }
}

struct UserStats {
    let followers : Int
    let following : Int
    let posts : Int
}
