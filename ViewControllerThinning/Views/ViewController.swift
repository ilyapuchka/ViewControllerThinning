//
//  ViewController.swift
//  ViewControllerThinning
//
//  Created by Ilya Puchka on 27.09.15.
//  Copyright © 2015 Ilya Puchka. All rights reserved.
//

import UIKit
import Dip

class ViewController: UIViewController {
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override var nibName: String {
        return "AuthView"
    }
    
    var authView: AuthView! {
        return view as! AuthView
    }
    
    private let _formBehaviour = Injected<AuthFormBehaviour>()
    
    var formBehaviour: AuthFormBehaviour? {
        return _formBehaviour.value
    }
    
    var animationsFactory: AnimationsFactory?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        formBehaviour?.onLoggedIn = {[unowned self] in self.handleLogin($0, performedRequest: $1)}
        
        formBehaviour?.userNameInput = authView.userNameInput
        formBehaviour?.userNameInput.delegate = formBehaviour
        
        formBehaviour?.passwordInput = authView.passwordInput
        formBehaviour?.passwordInput.delegate = formBehaviour
        
        authView.loginButton.addTarget(formBehaviour, action: "submitForm", forControlEvents: .TouchUpInside)
        authView.cancelButton.addTarget(formBehaviour, action: "cancelForm", forControlEvents: .TouchUpInside)

        authView.userNameInput.shakeAnimation = animationsFactory?.shakeAnimation(authView.userNameInput)
        authView.passwordInput.shakeAnimation = animationsFactory?.shakeAnimation(authView.passwordInput)
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

protocol AnimationsFactory {
    func shakeAnimation(view: UIView) -> ShakeAnimation
}


