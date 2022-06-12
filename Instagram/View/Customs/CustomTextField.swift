//
//  CustomTextField.swift
//  Instagram
//
//  Created by Omar Ahmed on 21/05/2022.
//

import UIKit


class CustomTextField : UITextField {
    
    // MARK: LifeCycle
    
    init(placeholder:String , keyboardtype:UIKeyboardType , issecure : Bool) {
        super.init(frame: .zero)
        
        let spacer = UIView()
        spacer.setDimensions(height: 50, width: 12)
        leftView = spacer
        leftViewMode = .always
        
        borderStyle = .none
        textColor = .white
        keyboardType = keyboardtype
        keyboardAppearance = .dark
        backgroundColor = UIColor(white: 1, alpha: 0.1)
        attributedPlaceholder = NSAttributedString(string: placeholder , attributes: [.foregroundColor:UIColor(white: 1, alpha: 0.7)])
        setHeight(50)
        isSecureTextEntry = issecure
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
