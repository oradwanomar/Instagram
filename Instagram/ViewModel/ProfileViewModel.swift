//
//  ProfileHeaderViewModel.swift
//  Instagram
//
//  Created by Omar Ahmed on 30/05/2022.
//

import Foundation
import UIKit
import Firebase


class ProfileViewModel {
    var user: User!
    {
        didSet {
            self.fetchUserFromAPI()
        }
    }

    var bindingUserViewModelToView : (()->()) = {}
    
    var username : String {
        return user.username
    }
    
    var fullname : String {
        return user.fullname
    }
    
    var profileImageUrl : URL? {
        return URL(string: user.profileImageUrl)
    }
    
    var followButtonText : String {
        if user.isCurrentUser {
            return "Edit Profile"
        }
        
        return user.isFollowed ? "Following" : "Follow"
    }
    
//    var followButtonBackgroundColor : UIColor {
//        if user.isCurrentUser {
//            return .systemBackground
//        }
//
//        return user.isFollowed ? .systemBackground : .systemBlue
//    }
    
    
    init() {
        self.fetchUserWithCompletion { user in
            self.user = user
        }
    }
    
    required init(user:User){
        self.user = user
    }
    
    func fetchUserFromAPI(){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        UserService.fetchUser(forUserID: uid) { user in
                self.user = user
        }
    }
    
    func fetchUserWithCompletion(completion:@escaping (User)->Void){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        UserService.fetchUser(forUserID: uid) { user in
            self.user = user
            completion(user)
        }
    }
    
    func checkIfUserIsFollow(completion: @escaping (Bool)->Void){
        UserService.checkIfUserIsFollowed(uid: user.uid) { isFollow in
            completion(isFollow)
        }
    }
    
    func fetchUserStats(completion: @escaping (UserStats)->Void){
        UserService.fetchUserStats(uid: user.uid) { stats in
            completion(stats)
        }
    }
    
}
