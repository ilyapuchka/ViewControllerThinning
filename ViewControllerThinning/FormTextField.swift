//
//  FormTextField.swift
//  ViewControllerThinning
//
//  Created by Ilya Puchka on 27.09.15.
//  Copyright © 2015 Ilya Puchka. All rights reserved.
//

import UIKit

extension ThemedView where Self: FormTextField {
    
    func attributedPlaceholder() -> NSAttributedString? {
        if let placeholder = placeholder {
            return NSAttributedString(string: placeholder, attributes: [
                NSForegroundColorAttributeName: theme.colorForTag(ThemeColorTag.PlaceholderColor)
                ])
        }
        return nil
    }

}

class FormTextField: UITextField, ThemedView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialized()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialized()
    }
    
    func initialized() {
        rightView = InvalidInputIndicator(textField: self)
        updateAppearance()
    }

    var theme: ColorTheme = FormTextFieldDefaultTheme() {
        didSet {
            updateAppearance()
        }
    }
    
    func updateAppearance() {
        tintColor = theme.colorForTag(ThemeColorTag.TintColor)
        textColor = theme.colorForTag(ThemeColorTag.TextColor)
        
        backgroundColor = highlighted ?
            theme.colorForTag(ThemeColorTag.HighlightedBackgroundColor) :
            theme.colorForTag(ThemeColorTag.BackgroundColor)
        
        attributedPlaceholder = attributedPlaceholder()
        leftView?.tintColor = theme.colorForTag(ThemeColorTag.LeftViewTintColor)
        rightView?.tintColor = theme.colorForTag(ThemeColorTag.RightViewTintColor)
        (rightView as? InvalidInputIndicator)?.backgroundColor = theme.colorForTag(ThemeColorTag.InvalidIndicatorColor)
    }
    
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

class InvalidInputIndicator: UIView {
    
    init(textField: FormTextField) {
        super.init(frame: CGRectMake(0, 0, CGRectGetHeight(textField.bounds)/5, CGRectGetHeight(textField.bounds)/5))
        self.layer.cornerRadius = CGRectGetHeight(self.bounds) / 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

