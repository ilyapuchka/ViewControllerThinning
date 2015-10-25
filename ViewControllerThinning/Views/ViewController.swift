//
//  ViewController.swift
//  ViewControllerThinning
//
//  Created by Ilya Puchka on 27.09.15.
//  Copyright © 2015 Ilya Puchka. All rights reserved.
//

import UIKit
import SwiftNetworking
import Typhoon

class ViewController: UIViewController {
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    var authView: AuthView! {
        return view as! AuthView
    }
    
    var formBehaviour: AuthFormBehaviour! {
        didSet {
            formBehaviour.onLoggedIn = {[unowned self] in self.handleLogin($0, performedRequest: $1)}
        }
    }
    
    func handleLogin(error: NSError?, performedRequest: Bool) {
        if let error = error {
            authView.userNameInput.invalidInput = error.isInvalidUserNameError()
            authView.passwordInput.invalidInput = error.isInvalidPasswordError()

            if performedRequest {
                self.displayError(error)
            }
        }
        else {
            authView.userNameInput.invalidInput = false
            authView.passwordInput.invalidInput = false
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
