//
//  AuthView.swift
//  ViewControllerThinning
//
//  Created by Ilya Puchka on 27.09.15.
//  Copyright © 2015 Ilya Puchka. All rights reserved.
//

import UIKit

class AuthView: UIView, UITextFieldDelegate {
    
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
            userNameInput.updateAppearance()
        }
    }
    
    @IBOutlet
    var passwordInput: FormTextField! {
        didSet {
            passwordInput.leftView = UIImageView(image: UIImage(.InputPasswordIcon))
            passwordInput.leftViewMode = UITextFieldViewMode.Always
            passwordInput.updateAppearance()
        }
    }

    @IBOutlet
    var loginButton: UIButton!

    var onLoginButtonTapped: ((username: String, password: String) -> Void)?
    
    @IBAction
    func loginButtonTapped(sender: UIButton) {
        endEditing()
        
        UIView.animateWithDuration(0.25, delay: 0, options: [UIViewAnimationOptions.BeginFromCurrentState], animations: { () -> Void in
            self.loginButton.backgroundColor = UIColor(red: 0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1)
            }, completion: nil)

        onLoginButtonTapped?(username: userNameInput.text!, password: passwordInput.text!)
    }

    @IBAction
    func loginButtonTouchBegin(sender: UIButton) {
        UIView.animateWithDuration(0.25, delay: 0, options: [UIViewAnimationOptions.BeginFromCurrentState], animations: { () -> Void in
            self.loginButton.backgroundColor = UIColor(red: 21.0/255.0, green: 160.0/255.0, blue: 255.0/255.0, alpha: 1)
            }, completion: nil)
    }
    
    @IBAction
    func forgottenPasswordTapped() {
        endEditing()
    }

    func textFieldDidBeginEditing(textField: UITextField) {
        self.changeAnimated(true, options: [.BeginFromCurrentState]) {
            textField.highlighted = true
            (textField as? ThemedView)?.updateAppearance()
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        self.changeAnimated(true, options: [.BeginFromCurrentState]) {
            textField.highlighted = false
            (textField as? ThemedView)?.updateAppearance()
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == userNameInput {
            passwordInput.becomeFirstResponder()
        }
        else {
            endEditing()
            onLoginButtonTapped?(username: userNameInput.text!, password: passwordInput.text!)
        }
        return true
    }
    
    var shakeAnimation: CAKeyframeAnimation = {
        let animation = CAKeyframeAnimation(keyPath: "position.x")
        animation.values = [0, 10, -8, 4, 0]
        animation.keyTimes = [ 0, (1 / 6.0), (3 / 6.0), (5 / 6.0), 1 ]
        animation.duration = 0.2
        animation.additive = true
        return animation
    }()

    func markUserNameAsInvalid(invalid: Bool) {
        markTextField(userNameInput, asInvalid: invalid)
    }
    
    func markPasswordAsInvalid(invalid: Bool) {
        markTextField(passwordInput, asInvalid: invalid)
    }
    
    private func markTextField(textField: UITextField, asInvalid invalid: Bool) {
        if invalid {
            textField.rightViewMode = .Always
            textField.layer.addAnimation(shakeAnimation, forKey: "shake")
        }
        else {
            textField.rightViewMode = .Never
        }
    }

}