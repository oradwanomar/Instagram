//
//  UploadPostViewController.swift
//  Instagram
//
//  Created by Omar Ahmed on 12/06/2022.
//

import UIKit

class UploadPostViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func configureUI(){
        title = "New Post"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .done, target: self, action: #selector(didTabShare))
    }
    
    //MARK: OBJ-C Functions
    
    @objc func didTapCancel(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func didTabShare(){
        
    }

}
