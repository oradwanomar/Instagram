//
//  UserViewModel.swift
//  Instagram
//
//  Created by Omar Ahmed on 02/06/2022.
//

import Foundation

class UserViewModel {
    var user: User
    
    var username : String {
        return user.username
    }
    
    var fullname : String {
        return user.fullname
    }
    
    var profileImageUrl : URL? {
        return URL(string: user.profileImageUrl)
    }
    
    init(user:User) {
        self.user = user
    }
    
}
