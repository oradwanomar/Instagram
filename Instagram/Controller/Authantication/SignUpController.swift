//
//  SighUpController.swift
//  Instagram
//
//  Created by Omar Ahmed on 20/05/2022.
//

import UIKit

class SignUpController : UIViewController {
    
    //MARK: Properties
    
    private let plusPhotoButton : UIButton = {
        let ppBtn = UIButton(type: .system)
        ppBtn.setImage(UIImage(named: "plus_photo"), for: .normal)
        ppBtn.tintColor = .white
        return ppBtn
    }()
    
    private let stackView : UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 20
        return sv
    }()
    
    private let emailTextField : UITextField = {
        let emailTxt = CustomTextField(placeholder: "Email", keyboardtype: .emailAddress, issecure: false)
        return emailTxt
    }()
    
    private let passwordTextField : UITextField = {
        let passwordTxt = CustomTextField(placeholder: "Password", keyboardtype: .default, issecure: true)
        return passwordTxt
    }()
    
    private let FullNameTextField = CustomTextField(placeholder: "Fullname", keyboardtype: .default, issecure: false)
    
    private let UserNameTextField = CustomTextField(placeholder: "Username", keyboardtype: .default, issecure: false)
    
    private let signUpBtn = CustomAuthButton(title: "Sign Up")
    
    
    
    
    //MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        configureUI()
        setUpConstrains()
        
    }
    
    func configureUI(){
        view.backgroundColor = .white
        configureGradientLayer()
        view.addSubview(plusPhotoButton)
        view.addSubview(stackView)
        [emailTextField,passwordTextField,FullNameTextField,UserNameTextField,signUpBtn].forEach {stackView.addArrangedSubview($0)}
    }
    
    func setUpConstrains(){
        plusPhotoButton.centerX(inView: view)
        plusPhotoButton.setDimensions(height: 130, width: 130)
        plusPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor,paddingTop: 32)
        
        stackView.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor,right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
    }
}
