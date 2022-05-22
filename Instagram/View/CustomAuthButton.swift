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
        setTitleColor(UIColor(white: 1, alpha: 0.4), for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        backgroundColor = .systemPurple.withAlphaComponent(0.5)
        setHeight(50)
        isEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
