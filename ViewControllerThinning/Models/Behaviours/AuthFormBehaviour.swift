//
//  AuthFormBehaviour.swift
//  ViewControllerThinning
//
//  Created by Ilya Puchka on 09.10.15.
//  Copyright © 2015 Ilya Puchka. All rights reserved.
//

import UIKit
import SwiftNetworking

protocol AuthFormBehaviour: FormBehaviour, UITextFieldDelegate {
    var userNameInput: UITextField! { get set }
    var passwordInput: UITextField! { get set }
    
    var onLoggedIn: ((error: NSError?, performedRequest: Bool) -> ())? { get set }
}

class AuthFormBehaviourImp: NSObject, AuthFormBehaviour {
    
    let apiClient: GhostApiClient
    
    init(apiClient: GhostApiClient) {
        self.apiClient = apiClient
    }
    
    var userNameInput: UITextField!
    var passwordInput: UITextField!
    
    var formFields: [UIView] {
        return [userNameInput, passwordInput]
    }
    
    @IBAction
    func submitForm() {
        guard let
            username = userNameInput.text,
            password = passwordInput.text else {
                return
        }
        userNameInput.endEditing(true)
        passwordInput.endEditing(true)
        login(username, password: password)
    }
    
    var onCancel: (()->())?
    
    @IBAction
    func cancelForm() {
        onCancel?()
    }
    
    var onLoggedIn: ((error: NSError?, performedRequest: Bool) -> ())?

    func login(username: String, password: String) {
        apiClient.login(username, password: password) { [weak self] (error, performedRequest) -> () in
            self?.onLoggedIn?(error: error, performedRequest: performedRequest)
        }
    }
    
}

extension AuthFormBehaviourImp {
    
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

