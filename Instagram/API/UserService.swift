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
}
