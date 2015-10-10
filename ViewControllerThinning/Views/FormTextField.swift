//
//  FormTextField.swift
//  ViewControllerThinning
//
//  Created by Ilya Puchka on 27.09.15.
//  Copyright © 2015 Ilya Puchka. All rights reserved.
//

import UIKit

class FormTextField: UITextField {
    
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
    
    var theme: FormTextFieldTheme = FormTextFieldDefaultTheme() {
        didSet {
            updateAppearance()
        }
    }
    
    func updateAppearance() {
        updateAppearance(theme)
    }
    
    func updateAppearance(theme: FormTextFieldTheme) {
        super.updateAppearance(theme)
        backgroundColor = highlighted ?
            theme.highlightedBackgroundColor :
            theme.backgroundColor
        (rightView as? InvalidInputIndicator)?.backgroundColor = theme.invalidIndicatorColor
    }
    
    @IBOutlet
    var shakeAnimation: ShakeAnimation?
    
    var invalidInput: Bool = false {
        didSet {
            rightViewMode = invalidInput ? .Always : .Never
            if invalidInput {
                shakeAnimation?.play()
            }
        }
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

//MARK: - Highlightable View
extension FormTextField: BackgroundHighlightableView {
    
    var backgroundColorForHighlightedState: UIColor? {
        get {
            return self.theme.highlightedBackgroundColor
        }
    }
    
    var backgroundColorForNormalState: UIColor? {
        get {
            return self.theme.backgroundColor
        }
    }
    
    override var highlighted: Bool {
        willSet {
            setHighlighted(newValue, animated: true)
        }
    }
    
    override func resignFirstResponder() -> Bool {
        let resignedFirstResponder = super.resignFirstResponder()
        highlighted = !resignedFirstResponder
        return resignedFirstResponder
    }
    
    override func becomeFirstResponder() -> Bool {
        let becameFirstResponder = super.becomeFirstResponder()
        highlighted = becameFirstResponder
        return becameFirstResponder
    }

}


