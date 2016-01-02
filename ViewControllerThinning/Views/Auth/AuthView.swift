//
//  AuthView.swift
//  ViewControllerThinning
//
//  Created by Ilya Puchka on 27.09.15.
//  Copyright © 2015 Ilya Puchka. All rights reserved.
//

import UIKit

class AuthView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addEndEditingTapRecognizer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addEndEditingTapRecognizer()
    }
    
    private lazy var endEditingTapRecognizer: UITapGestureRecognizer! = UITapGestureRecognizer(target: self, action: "endEditing")
    
    private func addEndEditingTapRecognizer() {
        self.addGestureRecognizer(endEditingTapRecognizer)
    }

    @objc func endEditing() {
        endEditing(true)
    }
    
    @IBOutlet
    var userNameInput: FormTextField! {
        didSet {
            userNameInput.leftView = UIImageView(image: UIImage(.InputEmailIcon))
            userNameInput.leftViewMode = UITextFieldViewMode.Always
        }
    }
    
    @IBOutlet
    var passwordInput: FormTextField! {
        didSet {
            passwordInput.leftView = UIImageView(image: UIImage(.InputPasswordIcon))
            passwordInput.leftViewMode = UITextFieldViewMode.Always
        }
    }

    @IBOutlet
    var loginButton: UIButton!
    
}