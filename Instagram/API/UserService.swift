//
//  UserService.swift
//  Instagram
//
//  Created by Omar Ahmed on 30/05/2022.
//

import Firebase

class UserService {
    
    static func fetchUser(comletion:@escaping (User)->Void){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        COLLECTION_USERS.document(uid).getDocument { snapshot, error in
            guard let userDic = snapshot?.data() else {return}
            let user = User(dictionary: userDic)
            comletion(user)
        }
    }
    
    static func fetchUsers(completion:@escaping ([User])->Void){
//        var users : [User] = []
        COLLECTION_USERS.getDocuments { snapshot, error in
            guard let snapshot = snapshot else {
                return
            }
//            snapshot.documents.forEach { document in
//                let user = User(dictionary: document.data())
//                users.append(user)
//            }
            let users = snapshot.documents.map({User(dictionary: $0.data())})
            completion(users)
        }
    }
    
    static func follow(uid:String,completion:@escaping (Error?)->Void){
        guard let currentUserId = Auth.auth().currentUser?.uid else {return}
        COLLECTION_FOLLOWING.document(currentUserId).collection("user-following").document(uid).setData([:]) { error in
            COLLECTION_FOLLOWERS.document(uid).collection("user-followers").document(currentUserId).setData([:], completion: completion)
        }
    }
    
    static func unfollow(uid: String,completion: @escaping (Error?)->Void){
        guard let currentId = Auth.auth().currentUser?.uid else {return}
        COLLECTION_FOLLOWING.document(currentId).collection("user-following").document(uid).delete { error in
            COLLECTION_FOLLOWERS.document(uid).collection("user-followers").document(currentId).delete(completion: completion)
        }
    }
    
    static func checkIfUserIsFollowed(uid:String,completion: @escaping (Bool)->Void){
        

    }
}
