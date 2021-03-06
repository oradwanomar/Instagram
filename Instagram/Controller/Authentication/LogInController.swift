//
//  LogInController.swift
//  Instagram
//
//  Created by Omar Ahmed on 20/05/2022.
//

import UIKit

protocol AuthDelegate {
    func authDidCompleted()
}

class LogInController : UIViewController {
    
    //MARK: Properties
    
    private var logInViewModel = LoginViewModel()
    var delegate : AuthDelegate?
    
    private let logoimage : UIImageView = {
        let logoimage = UIImageView(image: UIImage(named: "Instagram_logo_white"))
        logoimage.contentMode = .scaleAspectFill
        return logoimage
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
    
    private let loginBtn : UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Log In", for: .normal)
        btn.setTitleColor(UIColor(white: 1, alpha: 0.4), for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.backgroundColor = .systemPurple.withAlphaComponent(0.5)
        btn.isEnabled = false
        btn.addTarget(self, action: #selector(handleLogIn), for: .touchUpInside)
        btn.setHeight(50)
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
        configureTextFieldObserver()
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
    
    func configureTextFieldObserver(){
        emailTextField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
    }
    
    // MARK: OBJC Functions
    
    @objc func handleLogIn(){
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        showLoader(true)
        AuthService.logInUser(withEmail: email, withPassword: password) { result, error in
            self.showLoader(false)
            if let error = error {
                print("Error : in log in \(error.localizedDescription)")
                return
            }
            self.delegate?.authDidCompleted()
        }
    }
    
    @objc func goSignUp(){
        let signup = SignUpController()
        navigationController?.pushViewController(signup, animated: true)
    }
    
    @objc func textChanged(sender: UITextField){
        if sender == emailTextField {
            logInViewModel.email = sender.text
        }else {
            logInViewModel.password = sender.text
        }
        updateFormEffect()
    }
    
   
}

// MARK: Extension to conform protocol FormViewModel

extension LogInController : FormViewModel {
    func updateFormEffect() {
        loginBtn.backgroundColor = logInViewModel.buttonBackgroundColor
        loginBtn.setTitleColor(logInViewModel.buttonTitleColor, for: .normal)
        loginBtn.isEnabled = logInViewModel.formIsValid
    }
}
