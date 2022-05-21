//
//  SighUpController.swift
//  Instagram
//
//  Created by Omar Ahmed on 20/05/2022.
//

import UIKit

class SighUpController : UIViewController {
    
    //MARK: Properties
    
    
    //MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
    }
    
    func configureUI(){
        view.backgroundColor = .white
    }
}
