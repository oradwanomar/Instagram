//
//  LogInController.swift
//  Instagram
//
//  Created by Omar Ahmed on 20/05/2022.
//

import UIKit

class LogInController : UIViewController {
    
    //MARK: Properties
    
    private let logoimage : UIImageView = {
        let logoimage = UIImageView(image: UIImage(named: "Instagram_logo_white"))
        logoimage.contentMode = .scaleAspectFill
        return logoimage
    }()
    
    private let emailTextField : UITextField = {
        let emailTxt = CustomTextField(placeholder: "Email", keyboardtype: .emailAddress, issecure: false)
        return emailTxt
    }()
    
    private let passwordTextField : UITextField = {
        let passwordTxt = CustomTextField(placeholder: "Password", keyboardtype: .default, issecure: true)
        return passwordTxt
    }()
    
    private let stackView : UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 20
        return sv
    }()
    
    private let loginBtn : UIButton = {
        let btn = CustomAuthButton(title: "Log In")
        return btn
    }()
    
    private let forgetPassword : UIButton = {
        let Btn = UIButton(type: .system)
        Btn.attributedTitle(firstPart: "Forget your password? ", secondPart: "Get help signing in")
        return Btn
    }()
    
    private let dontHaveAccount : UIButton = {
        let Btn = UIButton(type: .system)
        Btn.attributedTitle(firstPart: "Don't have an account? ", secondPart: "Sign Up")
        Btn.addTarget(self, action: #selector(goSignUp), for: .touchUpInside)
        return Btn
    }()
    
    
    //MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        configureUI()
        setUpConstrains()
        
    }
    
    func configureUI(){
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        configureGradientLayer()
        
        view.addSubview(logoimage)
        [emailTextField,passwordTextField,loginBtn].forEach {stackView.addArrangedSubview($0)}
        view.addSubview(stackView)
        view.addSubview(dontHaveAccount)
        view.addSubview(forgetPassword)
    }
    
    func setUpConstrains(){
        logoimage.centerX(inView: view)
        logoimage.setDimensions(height: 80, width: 120)
        logoimage.anchor(top: view.safeAreaLayoutGuide.topAnchor,paddingTop: 32)
        
        stackView.anchor(top: logoimage.bottomAnchor, left: view.leftAnchor,right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        dontHaveAccount.centerX(inView: view)
        dontHaveAccount.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
        
        forgetPassword.centerX(inView: view)
        forgetPassword.anchor(top: stackView.bottomAnchor,paddingTop: 20)
    }
    
    @objc func goSignUp(){
        let signup = SignUpController()
        navigationController?.pushViewController(signup, animated: true)
    }
}
