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
        let emailTxt = UITextField()
        emailTxt.borderStyle = .none
        emailTxt.textColor = .white
        emailTxt.keyboardType = .emailAddress
        emailTxt.keyboardAppearance = .dark
        emailTxt.backgroundColor = UIColor(white: 1, alpha: 0.1)
        emailTxt.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [.foregroundColor:UIColor(white: 1, alpha: 0.7)])
        emailTxt.setHeight(50)
        return emailTxt
    }()
    
    private let passwordTextField : UITextField = {
        let passwordTxt = UITextField()
        passwordTxt.borderStyle = .none
        passwordTxt.textColor = .white
        passwordTxt.keyboardType = .default
        passwordTxt.keyboardAppearance = .dark
        passwordTxt.backgroundColor = UIColor(white: 1, alpha: 0.1)
        passwordTxt.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [.foregroundColor:UIColor(white: 1, alpha: 0.5)])
        passwordTxt.setHeight(50)
        passwordTxt.isSecureTextEntry = true
        return passwordTxt
    }()
    
    private let stackView : UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 20
        return sv
    }()
    
    private let loginBtn : UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Log In", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.backgroundColor = .systemPurple.withAlphaComponent(0.3)
        btn.setHeight(50)
        return btn
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
        
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.purple.cgColor,UIColor.systemBlue.cgColor]
        gradient.locations = [0,1]
        view.layer.addSublayer(gradient)
        gradient.frame = view.frame
        
        view.addSubview(logoimage)
        [emailTextField,passwordTextField,loginBtn].forEach {stackView.addArrangedSubview($0)}
        view.addSubview(stackView)
    }
    
    func setUpConstrains(){
        logoimage.centerX(inView: view)
        logoimage.setDimensions(height: 80, width: 120)
        logoimage.anchor(top: view.safeAreaLayoutGuide.topAnchor,paddingTop: 32)
        
        stackView.anchor(top: logoimage.bottomAnchor, left: view.leftAnchor,right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
    }
}
