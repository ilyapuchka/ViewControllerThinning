//
//  TextFieldTheme.swift
//  ViewControllerThinning
//
//  Created by Ilya Puchka on 03.10.15.
//  Copyright © 2015 Ilya Puchka. All rights reserved.
//

import UIKit

protocol TextFieldTheme {
    var textColor: UIColor {get}
    var placeholderColor: UIColor {get}
    var tintColor: UIColor {get}
    var leftViewTintColor: UIColor {get}
    var rightViewTintColor: UIColor {get}
    var backgroundColor: UIColor {get}
}

//Default text field theme
extension TextFieldTheme {
    var textColor: UIColor {
        return UIColor.blackColor()
    }
    var placeholderColor: UIColor {
        return UIColor.lightTextColor()
    }
    var tintColor: UIColor {
        return UIColor(red: 0, green: 100.0/255.0, blue: 220.0/255.0, alpha: 1)
    }
    var leftViewTintColor: UIColor {
        return UIColor(red: 0, green: 122.0/255.0, blue: 1, alpha: 1)
    }
    var rightViewTintColor: UIColor {
        return UIColor(red: 0, green: 122.0/255.0, blue: 1, alpha: 1)
    }
    var backgroundColor: UIColor {
        return UIColor.whiteColor()
    }
}

extension UITextField {
    func updateAppearance(theme: TextFieldTheme) {
        tintColor = theme.tintColor
        textColor = theme.textColor
        backgroundColor = theme.backgroundColor
        leftView?.tintColor = theme.leftViewTintColor
        rightView?.tintColor = theme.rightViewTintColor
        attributedPlaceholder = attributedPlaceholder(theme)
    }
    
    func attributedPlaceholder(theme: TextFieldTheme) -> NSAttributedString? {
        if let placeholder = placeholder {
            return NSAttributedString(string: placeholder, attributes: [
                NSForegroundColorAttributeName: theme.placeholderColor
                ])
        }
        return nil
    }
}


