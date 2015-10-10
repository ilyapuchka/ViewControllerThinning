//
//  FormBehaviour.swift
//  ViewControllerThinning
//
//  Created by Ilya Puchka on 09.10.15.
//  Copyright © 2015 Ilya Puchka. All rights reserved.
//

import UIKit

protocol FormBehaviour {
    var formFields: [UIView]! {get}
    func goToNextFormField() -> UIView?
    func currentFormField() -> UIView?
    func submitForm()
    func cancelForm()
}

extension FormBehaviour {
    
    func currentFormField() -> UIView? {
        for field in formFields where field.isFirstResponder() {
            return field
        }
        return nil
    }
    
    func goToNextFormField() -> UIView? {
        guard let
            formFields = self.formFields,
            currentField = currentFormField(),
            currentFieldIndex = formFields.indexOf(currentField)
            where
            formFields.count > 1
            else {
                return nil
        }
        
        var nextFormField: UIView! = nil
        var nextIndex = currentFieldIndex
        repeat {
            nextIndex = (nextIndex + 1) % formFields.count
            nextFormField = formFields[nextIndex]
        } while nextFormField.canBecomeFirstResponder() == false && nextIndex != currentFieldIndex
        if nextIndex != currentFieldIndex {
            nextFormField.becomeFirstResponder()
        }
        return nextFormField
    }
    
}
