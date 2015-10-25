//
//  AuthFormBehaviour.swift
//  ViewControllerThinning
//
//  Created by Ilya Puchka on 09.10.15.
//  Copyright © 2015 Ilya Puchka. All rights reserved.
//

import UIKit
import SwiftNetworking

class AuthFormBehaviour: NSObject, FormBehaviour {
    
    let apiClient: APIClient
    
    init(APIClient apiClient: APIClientBox) {
        self.apiClient = apiClient.unboxed
    }
    
    var userNameInput: UITextField! {
        didSet {
            userNameInput.delegate = self
        }
    }
    
    var passwordInput: UITextField! {
        didSet {
            passwordInput.delegate = self
        }
    }
    
    var formFields: [UIView]! {
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

extension AuthFormBehaviour: UITextFieldDelegate {
    
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

