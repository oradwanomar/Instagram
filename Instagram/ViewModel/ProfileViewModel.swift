//
//  ProfileHeaderViewModel.swift
//  Instagram
//
//  Created by Omar Ahmed on 30/05/2022.
//

import Foundation


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
    
    init() {
        self.fetchUserWithCompletion { user in
            self.user = user
        }
    }
    
    func fetchUserFromAPI(){
        UserService.fetchUser { user in
                self.user = user
        }
    }
    
    func fetchUserWithCompletion(completion:@escaping (User)->Void){
        UserService.fetchUser { user in
            self.user = user
            completion(user)
        }
    }
    
}
