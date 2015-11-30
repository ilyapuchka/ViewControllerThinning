//
//  GhostApiClient.swift
//  ViewControllerThinning
//
//  Created by Ilya Puchka on 29.11.15.
//  Copyright © 2015 Ilya Puchka. All rights reserved.
//

import SwiftNetworking

protocol GhostApiClient {
    func login(username: String?, password: String?, completion: (error: NSError?, performedRequest: Bool)->())
}

extension APIClient: GhostApiClient {
    
    //Fake login
    func login(username: String?, password: String?, completion: (error: NSError?, performedRequest: Bool)->()) {
        
        var error: NSError?
        var performedRequest: Bool = false
        if username == nil || username?.characters.count == 0 {
            error = NSError.errorWithUnderlyingError(NSError(code: .InvalidUserName), code: .InvalidCredentials)
        }
        else if password == nil || password?.characters.count == 0 {
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
