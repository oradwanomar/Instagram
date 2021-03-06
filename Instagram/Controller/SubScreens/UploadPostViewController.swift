//
//  UploadPostViewController.swift
//  Instagram
//
//  Created by Omar Ahmed on 12/06/2022.
//

import UIKit

protocol UploadPostControllerDelegate: AnyObject {
    func didFinishUploadPost(_ controller: UploadPostViewController)
}

class UploadPostViewController: UIViewController {
    
    //MARK: Properties
    
    weak var delegate: UploadPostControllerDelegate?
    var currentUser: User?
    
    var selectedImage: UIImage? {
        didSet {photoSelected.image = selectedImage}
    }
    
    private let photoSelected : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private lazy var captionTextView : CaptionTextView = {
        let ctv = CaptionTextView()
        ctv.placeholderText = "Enter caption..."
        ctv.font = UIFont.systemFont(ofSize: 16)
        ctv.delegate = self
        ctv.placeholderShouldCenter = false
        return ctv
    }()
    
    private let charactersCountLabel : UILabel = {
        let chars = UILabel()
        chars.font = UIFont.systemFont(ofSize: 14)
        chars.tintColor = .lightGray
        chars.text = "0/100"
        return chars
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setUpConstrains()
    }
    
    func checkMaxLength(_ textview: UITextView,maxLength: Int){
        if textview.text.count > maxLength {
            textview.deleteBackward() 
        }
    }
    
    func configureUI(){
        view.backgroundColor = .systemBackground
        title = "New Post"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancel))
        navigationItem.leftBarButtonItem?.tintColor = .label
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .done, target: self, action: #selector(didTabShare))
        navigationItem.rightBarButtonItem?.tintColor = .label
        view.addSubview(photoSelected)
        view.addSubview(captionTextView)
        view.addSubview(charactersCountLabel)
    }
    
    func setUpConstrains(){
        photoSelected.setDimensions(height: 200, width: 200)
        photoSelected.layer.cornerRadius = 20
        photoSelected.centerX(inView: view)
        photoSelected.anchor(top:view.safeAreaLayoutGuide.topAnchor,paddingTop: 12)
        
        captionTextView.anchor(top: photoSelected.bottomAnchor,left: view.leftAnchor,right: view.rightAnchor,paddingTop: 16,paddingLeft: 12,paddingRight: 12,height: 64)
        
        charactersCountLabel.anchor(top: captionTextView.bottomAnchor,right:view.rightAnchor,paddingBottom: -8,paddingRight: 12)
    }
    
    //MARK: OBJ-C Functions
    
    @objc func didTapCancel(){
        self.delegate?.didFinishUploadPost(self)
    }
    
    
    @objc func didTabShare(){
        guard let caption = captionTextView.text else {return}
        guard let selectedImage = selectedImage else {return}
        guard let currentUser = currentUser else {return}
        showLoader(true)
        PostService.uploadPost(caption: caption, user: currentUser, image: selectedImage) { error in
            self.showLoader(false)
            if let error = error {
                print("Error: Failed to upload post with \(error.localizedDescription)")
            }
        }
        self.delegate?.didFinishUploadPost(self)
    }

}

// MARK: UITextViewDelegate 

extension UploadPostViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        checkMaxLength(textView, maxLength: 100)
        let count = textView.text.count
        charactersCountLabel.text = "\(count)/100"
    }
}
