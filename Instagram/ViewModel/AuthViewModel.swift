//
//  AuthenticationViewModel.swift
//  Instagram
//
//  Created by Omar Ahmed on 22/05/2022.
//

import UIKit


protocol FormViewModel {
    func updateFormEffect()
}

protocol AuthViewModelProtocol {
    var formIsValid : Bool {get}
    var buttonBackgroundColor : UIColor {get}
    var buttonTitleColor : UIColor {get}
}

struct LoginViewModel : AuthViewModelProtocol {
    var email : String?
    var password : String?
    
    var formIsValid : Bool {
        return email?.isEmpty == false && password?.isEmpty == false && email?.isValidEmail == true
    }
    
    var buttonBackgroundColor : UIColor {
        return formIsValid ? .purple : .systemPurple.withAlphaComponent(0.5)
    }
    
    var buttonTitleColor : UIColor {
        return formIsValid ? .white : UIColor(white: 1, alpha: 0.4)
    }
}

struct SignUpViewModel : AuthViewModelProtocol {
    var email : String?
    var password : String?
    var fullname : String?
    var username : String?
    
    
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false && fullname?.isEmpty == false && username?.isEmpty == false && email?.isValidEmail == true
    }
    
    var buttonBackgroundColor: UIColor {
        return formIsValid ? .purple : .systemPurple.withAlphaComponent(0.5)
    }
    
    var buttonTitleColor: UIColor {
        return formIsValid ? .white : UIColor(white: 1, alpha: 0.4)
    }
    
    
}
