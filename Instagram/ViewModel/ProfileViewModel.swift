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
        self.fetchUserFromAPI()
    }
    
    func fetchUserFromAPI(){
        UserService.fetchUser { user in
                self.user = user
        }
    }
    
}