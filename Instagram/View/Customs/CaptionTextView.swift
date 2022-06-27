//
//  CaptionTextField.swift
//  Instagram
//
//  Created by Omar Ahmed on 12/06/2022.
//

import UIKit

class CaptionTextView : UITextView {
    
    var placeholderText : String? {
        didSet {
            placeholder.text = placeholderText
        }
    }
    
    let placeholder : UILabel = {
        let ph = UILabel()
        ph.textColor = .lightGray
        return ph
    }()
    
    var placeholderShouldCenter = true {
        didSet {
            if placeholderShouldCenter {
                placeholder.anchor(left: leftAnchor, right: rightAnchor,paddingLeft: 8)
                placeholder.centerY(inView: self)
            }else {
                placeholder.anchor(top: topAnchor,left: leftAnchor,paddingTop: 6,paddingLeft: 8)
            }
        }
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?){
        super.init(frame: frame, textContainer: textContainer)
        
        addSubview(placeholder)
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextDidChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    @objc func handleTextDidChange(){
        placeholder.isHidden = !text.isEmpty
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
