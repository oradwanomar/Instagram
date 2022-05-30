//
//  AuthService.swift
//  Instagram
//
//  Created by Omar Ahmed on 22/05/2022.
//

import Foundation
import UIKit
import Firebase

struct AuthService {
    
    static func logInUser(withEmail email:String,withPassword password:String,completion:@escaping(AuthDataResult?, Error?) -> Void ){
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    static func regesterUser(authcredential:AuthCredentials,completion:@escaping (Error?)->Void){
        ImageUploader.imageUploader(image: authcredential.profileImage) { imageUrl in
            Auth.auth().createUser(withEmail: authcredential.email, password: authcredential.password) { result, error in
                if let error = error {
                    print("Error in register user \(error.localizedDescription)")
                    return
                }
                guard let uid = result?.user.uid else {return}
                let userData : [String:Any] = [
                    "email":authcredential.email,
                    "fullname":authcredential.fullname,
                    "profileImageUrl":imageUrl,
                    "uid":uid,
                    "username":authcredential.username
                ]
                COLLECTION_USERS.document(uid).setData(userData, completion: completion)
            }
        }
    }
}
