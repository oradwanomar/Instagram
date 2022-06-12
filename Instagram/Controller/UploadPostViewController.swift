//
//  UploadPostViewController.swift
//  Instagram
//
//  Created by Omar Ahmed on 12/06/2022.
//

import UIKit

class UploadPostViewController: UIViewController {
    
    //MARK: Properties
    
    private let photoSelected : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private let captionTextView : UITextView = {
        let ctv = UITextView()
        return ctv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func configureUI(){
        title = "New Post"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .done, target: self, action: #selector(didTabShare))
        view.addSubview(photoSelected)
    }
    
    func setUpConstrains(){
        photoSelected.setDimensions(height: 200, width: 200)
        photoSelected.layer.cornerRadius = 20
        photoSelected.centerX(inView: view)
        photoSelected.anchor(top:view.topAnchor)
    }
    
    //MARK: OBJ-C Functions
    
    @objc func didTapCancel(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func didTabShare(){
        
    }

}
