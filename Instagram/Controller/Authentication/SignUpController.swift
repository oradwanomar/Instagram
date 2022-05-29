//
//  SighUpController.swift
//  Instagram
//
//  Created by Omar Ahmed on 20/05/2022.
//

import UIKit

class SignUpController : UIViewController {
    
    //MARK: Properties
    
    private var signupViewModel = SignUpViewModel()
    private var profileImage : UIImage?
    
    
    private let plusPhotoButton : UIButton = {
        let ppBtn = UIButton(type: .system)
        ppBtn.setImage(UIImage(named: "plus_photo"), for: .normal)
        ppBtn.tintColor = .white
        ppBtn.addTarget(self, action: #selector(getProfileImage), for: .touchUpInside)
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
    
    private let signUpBtn : UIButton = {
        let btn = UIButton(type: .system)
            btn.setTitle("Sign Up", for: .normal)
            btn.setTitleColor(UIColor(white: 1, alpha: 0.4), for: .normal)
            btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            btn.backgroundColor = .systemPurple.withAlphaComponent(0.5)
            btn.isEnabled = false
        btn.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
            btn.setHeight(50)
        return btn
    }()
    
    private let alreadyHaveAccount : UIButton = {
        let Btn = UIButton(type: .system)
        Btn.attributedTitle(firstPart: "Already have an account? ", secondPart: "Log In")
        Btn.addTarget(self, action: #selector(goLogIn), for: .touchUpInside)
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
        configureGradientLayer()
        view.addSubview(plusPhotoButton)
        view.addSubview(stackView)
        [emailTextField,passwordTextField,FullNameTextField,UserNameTextField,signUpBtn].forEach {stackView.addArrangedSubview($0)}
        view.addSubview(alreadyHaveAccount)
    }
    
    func setUpConstrains(){
        plusPhotoButton.centerX(inView: view)
        plusPhotoButton.setDimensions(height: 130, width: 130)
        plusPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor,paddingTop: 32)
        
        stackView.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor,right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        alreadyHaveAccount.centerX(inView: view)
        alreadyHaveAccount.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
        
    }
    
    func configureTextFieldObserver() {
        emailTextField.addTarget(self, action: #selector(didTextFieldChanged), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(didTextFieldChanged), for: .editingChanged)
        FullNameTextField.addTarget(self, action: #selector(didTextFieldChanged), for: .editingChanged)
        UserNameTextField.addTarget(self, action: #selector(didTextFieldChanged), for: .editingChanged)
    }
    
    
    // MARK: OBJC Functions
    
    @objc func handleSignUp(){
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        guard let fullname = FullNameTextField.text else {return}
        guard let username = UserNameTextField.text?.lowercased() else {return}
        guard let pImage = self.profileImage else {return}
        let user = AuthCredentials(email: email, password: password, fullname: fullname, username: username, profileImage: pImage)
        AuthService.regesterUser(authcredential: user) { error in
            if let error = error {
                print("Error : in user registeration \(error.localizedDescription)")
                return
            }
            print("Succesfully registration")
        }

    }
    
   @objc func didTextFieldChanged(sender:UITextField){
        if sender == emailTextField {
            signupViewModel.email = sender.text
        }else if sender == passwordTextField {
            signupViewModel.password = sender.text
        }else if sender == FullNameTextField {
            signupViewModel.fullname = sender.text
        }else {
            signupViewModel.username = sender.text
        }
        updateFormEffect()
    }
    
    @objc func goLogIn(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func getProfileImage(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    
}

// MARK: Extension to conform protocol FormViewModel

extension SignUpController : FormViewModel {
    func updateFormEffect() {
        signUpBtn.backgroundColor = signupViewModel.buttonBackgroundColor
        signUpBtn.setTitleColor(signupViewModel.buttonTitleColor, for: .normal)
        signUpBtn.isEnabled = signupViewModel.formIsValid
    }
}

// MARK: Extension to conform protocol UIImagePicker

extension SignUpController : UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.editedImage] as? UIImage else {return}
        profileImage = selectedImage
        plusPhotoButton.layer.cornerRadius = plusPhotoButton.frame.width / 2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.black.cgColor
        plusPhotoButton.layer.borderWidth = 1
        plusPhotoButton.setImage(selectedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        self.dismiss(animated: true, completion: nil)
    }
}
