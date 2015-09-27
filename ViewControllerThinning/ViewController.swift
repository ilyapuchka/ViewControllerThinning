//
//  ViewController.swift
//  ViewControllerThinning
//
//  Created by Ilya Puchka on 27.09.15.
//  Copyright © 2015 Ilya Puchka. All rights reserved.
//

import UIKit
import SwiftNetworking

class ViewController: UIViewController, UITextFieldDelegate {

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
            userNameInput.updateAppearance()
        }
    }
    
    @IBOutlet
    var loginButton: UIButton!

    var endEditingTapRecognizer: UITapGestureRecognizer! {
        return UITapGestureRecognizer(target: self, action: "endEditing")
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    var apiClient: APIClient = APIClient(baseURL: NSURL(string: "http://localhost")!)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addGestureRecognizer(endEditingTapRecognizer)
    }

    @IBAction
    func loginButtonTapped(sender: UIButton) {
        endEditing()
        
        UIView.animateWithDuration(0.25, delay: 0, options: [UIViewAnimationOptions.BeginFromCurrentState], animations: { () -> Void in
            self.loginButton.backgroundColor = UIColor(red: 0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1)
            }, completion: nil)
        
        login()
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
    
    func endEditing() {
        view.endEditing(true)
    }

    func textFieldDidBeginEditing(textField: UITextField) {
        self.view.changeAnimated(true, options: [.BeginFromCurrentState]) {
            textField.highlighted = true
            (textField as? ThemedView)?.updateAppearance()
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        self.view.changeAnimated(true, options: [.BeginFromCurrentState]) {
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
            login()
        }
        return true
    }
    
    func login() {
        apiClient.login(userNameInput.text, password: passwordInput.text, completion: onLoggedIn)
    }
    
    func onLoggedIn(error: NSError?, performedRequest: Bool) {
        if let error = error {
            
            let isBackendError = error.domain == NetworkErrorDomain
            var message: String?
            if isBackendError {
                if let underlyingError = error.userInfo[NSUnderlyingErrorKey] where
                    error.code == NetworkErrorCode.InvalidCredentials.rawValue {
                        
                        let animation = CAKeyframeAnimation(keyPath: "position.x")
                        animation.values = [0, 10, -8, 4, 0]
                        animation.keyTimes = [ 0, (1 / 6.0), (3 / 6.0), (5 / 6.0), 1 ]
                        animation.duration = 0.2
                        animation.additive = true
                        
                        if underlyingError.code == NetworkErrorCode.InvalidUserName.rawValue {
                            userNameInput.rightViewMode = .Always
                            userNameInput.layer.addAnimation(animation, forKey: "shake")
                            message = "Invalid login."
                        }
                        else if underlyingError.code == NetworkErrorCode.InvalidPassword.rawValue {
                            passwordInput.rightViewMode = .Always
                            passwordInput.layer.addAnimation(animation, forKey: "shake")
                            message = "Invalid password."
                        }
                }
                else {
                    userNameInput.rightViewMode = .Never
                    passwordInput.rightViewMode = .Never
                    message = error.userInfo[NSLocalizedDescriptionKey] as? String
                }
            }
            
            if performedRequest {
                let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel, handler: nil))
                presentViewController(alert, animated: true, completion: nil)
            }
        }
        else {
            userNameInput.rightViewMode = .Never
            passwordInput.rightViewMode = .Never
            //go to next screen
        }
    }

}

extension APIClient {
    
    //Fake login
    func login(username: String!, password: String!, completion: (error: NSError?, performedRequest: Bool)->()) {
        
        var error: NSError?
        var performedRequest: Bool = false
        if username == nil || username.characters.count == 0 {
            error = NSError.errorWithUnderlyingError(NSError(code: .InvalidUserName), code: .InvalidCredentials)
        }
        else if password == nil || password.characters.count == 0 {
            error = NSError.errorWithUnderlyingError(NSError(code: .InvalidPassword), code: .InvalidCredentials)
        }
        else {
            error = NSError(code: NetworkErrorCode.BackendError, userInfo: [NSLocalizedDescriptionKey: "Failed to login."])
            performedRequest = true
        }

        dispatch_after(1, dispatch_get_main_queue()) {
            completion(error: error, performedRequest: performedRequest)
        }
    }
}
