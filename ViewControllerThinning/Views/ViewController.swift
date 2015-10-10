//
//  ViewController.swift
//  ViewControllerThinning
//
//  Created by Ilya Puchka on 27.09.15.
//  Copyright © 2015 Ilya Puchka. All rights reserved.
//

import UIKit
import SwiftNetworking

class ViewController: UIViewController, AuthFormBehaviour {

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override var nibName: String? {
        return "AuthView"
    }
    
    var authView: AuthView! {
        return view as! AuthView
    }
    
    var apiClient: APIClient = APIClient(baseURL: NSURL(string: "http://localhost")!)
    
    @IBOutlet
    var userNameInput: UITextField! {
        didSet {
            userNameInput.delegate = self
        }
    }
    
    @IBOutlet
    var passwordInput: UITextField! {
        didSet {
            passwordInput.delegate = self
        }
    }
    
    @IBOutlet
    var formFields: [UIView]!

    var onCancel: (()->())?
    lazy var onLoggedIn: ((error: NSError?, performedRequest: Bool) -> ())? = {[weak self] in
        return self?.handleLogin
    }()
    
    @IBAction
    func onSubmitForm() {
        self.submitForm()
    }
    
    func handleLogin(error: NSError?, performedRequest: Bool) {
        if let error = error {
            
            let isBackendError = error.domain == NetworkErrorDomain
            var message: String?
            if isBackendError {
                if let underlyingError = error.userInfo[NSUnderlyingErrorKey] where
                    error.code == NetworkErrorCode.InvalidCredentials.rawValue {
                        
                        if underlyingError.code == NetworkErrorCode.InvalidUserName.rawValue {
                            authView.userNameInput.invalidInput = true
                            message = "Invalid login."
                        }
                        else {
                            authView.userNameInput.invalidInput = false
                        }
                        
                        if underlyingError.code == NetworkErrorCode.InvalidPassword.rawValue {
                            authView.passwordInput.invalidInput = true
                            message = "Invalid password."
                        }
                        else {
                            authView.passwordInput.invalidInput = false
                        }
                }
                else {
                    authView.userNameInput.invalidInput = false
                    authView.passwordInput.invalidInput = false
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
            authView.userNameInput.invalidInput = false
            authView.passwordInput.invalidInput = false
            //go to next screen
        }
    }

}

//MARK: - UITextFieldDelegate
extension ViewController {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == formFields.last {
            submitForm()
        }
        else {
            goToNextFormField()
        }
        return true
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
