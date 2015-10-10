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
    
    var apiClient: APIClient {get}
    
    var userNameInput: UITextField! {get}
    var passwordInput: UITextField! {get}
    
    var onCancel: (()->())? {get set}
    var onLoggedIn: ((error: NSError?, performedRequest: Bool) -> ())? {get set}
    
}

extension AuthFormBehaviour {
    
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
    
    func cancelForm() {
        onCancel?()
    }

    func login(username: String, password: String) {
        apiClient.login(username, password: password) { [weak self] (error, performedRequest) -> () in
            self?.onLoggedIn?(error: error, performedRequest: performedRequest)
        }
    }

}

