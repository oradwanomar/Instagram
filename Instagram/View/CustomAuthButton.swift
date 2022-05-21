//
//  CustomAuthButton.swift
//  Instagram
//
//  Created by Omar Ahmed on 22/05/2022.
//

import UIKit

class CustomAuthButton : UIButton {
    
    init(title : String) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        backgroundColor = .systemPurple.withAlphaComponent(0.3)
        setHeight(50)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
