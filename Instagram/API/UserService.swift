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
        COLLECTION_USERS.getDocuments { snapshot, error in
            guard let snapshot = snapshot else {return}
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
        guard let currentId = Auth.auth().currentUser?.uid else {return}
        COLLECTION_FOLLOWING.document(currentId).collection("user-following").document(uid).getDocument { snapshot, error in
            guard let isFollowed = snapshot?.exists else {return}
            completion(isFollowed)
        }
    }
    
    static func fetchUserStats(uid: String,completion: @escaping (UserStats)->Void){
        COLLECTION_FOLLOWERS.document(uid).collection("user-followers").getDocuments { snapshot, error in
            guard let followers = snapshot?.documents.count else {return}
            COLLECTION_FOLLOWING.document(uid).collection("user-following").getDocuments { snapshot, error in
                guard let following = snapshot?.documents.count else {return}
                COLLECTION_POSTS.whereField("currentUid", isEqualTo: uid).getDocuments { snapshot, error in
                    let posts = snapshot?.documents.count ?? 0
                    completion(UserStats(followers: followers, following: following, posts: posts))
                }
            }
        }
    }
}
