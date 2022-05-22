//
//  AuthenticationViewModel.swift
//  Instagram
//
//  Created by Omar Ahmed on 22/05/2022.
//

import UIKit

class LoginViewModel {
    var email : String?
    var password : String?
    
    var formIsValid : Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
    
    var buttonBackgroundColor : UIColor {
        return formIsValid ? .purple : .systemPurple.withAlphaComponent(0.5)
    }
    
    var buttonTitleColor : UIColor {
        return formIsValid ? .white : UIColor(white: 1, alpha: 0.4)
    }
}

class SignUpViewModel {
    
}
