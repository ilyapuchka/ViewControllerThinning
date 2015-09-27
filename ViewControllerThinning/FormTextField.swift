//
//  FormTextField.swift
//  ViewControllerThinning
//
//  Created by Ilya Puchka on 27.09.15.
//  Copyright © 2015 Ilya Puchka. All rights reserved.
//

import UIKit

class FormTextField: UITextField {
    
    override func leftViewRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectMake(bounds.size.height / 5, bounds.size.height / 3, bounds.size.height / 3, bounds.size.height / 3)
    }
    
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        var rect = bounds
        rect.origin.x = CGRectGetMaxX(leftViewRectForBounds(bounds)) + leftViewRectForBounds(bounds).origin.x
        let rightViewOriginX = rightView != nil ? rightViewRectForBounds(bounds).origin.x : clearButtonRectForBounds(bounds).origin.x
        rect.size.width = rightViewOriginX - rect.origin.x
        return rect
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return textRectForBounds(bounds)
    }
    
    override func rightViewRectForBounds(bounds: CGRect) -> CGRect {
        if let _ = rightView {
            return CGRectOffset(super.rightViewRectForBounds(bounds), -bounds.size.height / 5, 0)
        }
        else {
            return super.rightViewRectForBounds(bounds)
        }
    }
    
}
