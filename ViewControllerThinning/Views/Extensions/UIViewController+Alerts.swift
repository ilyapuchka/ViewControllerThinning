//
//  UIViewController+Alerts.swift
//  ViewControllerThinning
//
//  Created by Ilya Puchka on 10.10.15.
//  Copyright © 2015 Ilya Puchka. All rights reserved.
//

import Foundation
import SwiftNetworking

extension NSError {
    
    var underlyingError: NSError? {
        return userInfo[NSUnderlyingErrorKey] as? NSError
    }
    
    var userReadableMessage: String? {
        return userInfo[NSLocalizedDescriptionKey] as? String ?? NSLocalizedString("Something went wrong.", comment: "")
    }
    
    var alertMessage: String? {
        return userReadableMessage
    }
    
    func isInvalidUserNameError() -> Bool {
        return domain == NetworkErrorDomain && underlyingError?.code == NetworkErrorCode.InvalidUserName.rawValue
    }
    
    func isInvalidPasswordError() -> Bool {
        return domain == NetworkErrorDomain && underlyingError?.code == NetworkErrorCode.InvalidPassword.rawValue
    }
}

extension UIViewController {
    
    func displayError(error: NSError) {
        let alert = UIAlertController(title: NSLocalizedString("Error", comment: ""), message: error.alertMessage, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: UIAlertActionStyle.Cancel, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
    
}