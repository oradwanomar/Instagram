//
//  AuthService.swift
//  Instagram
//
//  Created by Omar Ahmed on 22/05/2022.
//

import Foundation
import UIKit
import Firebase

struct AuthCredentials {
    let email : String
    let password : String
    let fullname : String
    let username : String
    let profileImage : UIImage
}

struct AuthService {
    static func regesterUser(authcredential:AuthCredentials){
        print("\(authcredential)")
    }
}
