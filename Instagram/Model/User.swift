//
//  User.swift
//  Instagram
//
//  Created by Omar Ahmed on 30/05/2022.
//

import Foundation

struct User {
    let email: String
    let username: String
    let uid: String
    let fullname: String
    let profileImageUrl: String
    
    init(dictionary:[String:Any]){
        self.email = dictionary["email"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
    }
}
