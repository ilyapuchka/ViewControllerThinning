//
//  FormTextFieldTheme.swift
//  ViewControllerThinning
//
//  Created by Ilya Puchka on 17.09.15.
//  Copyright © 2015 Ilya Puchka. All rights reserved.
//

import UIKit

protocol HighlightedBackgroundTheme {
    var highlightedBackgroundColor: UIColor {get}
}

protocol FormTextFieldTheme: TextFieldTheme, HighlightedBackgroundTheme {
    var invalidIndicatorColor: UIColor {get}
}

extension FormTextFieldTheme {
    var highlightedBackgroundColor: UIColor {
        return backgroundColor
    }
    
    var invalidIndicatorColor: UIColor {
        return UIColor(red: 220.0/255.0, green: 0, blue: 0, alpha: 1)
    }
}

struct FormTextFieldDefaultTheme: FormTextFieldTheme {}

struct FormTextFieldCustomTheme: FormTextFieldTheme {
    
    var textColor: UIColor {
        return UIColor.whiteColor()
    }
    var placeholderColor: UIColor {
        return UIColor.lightTextColor()
    }
    var tintColor: UIColor {
        return UIColor.whiteColor()
    }
    var leftViewTintColor: UIColor {
        return placeholderColor
    }
    var rightViewTintColor: UIColor {
        return placeholderColor
    }
    var backgroundColor: UIColor {
        return UIColor(red: 103.0/255.0, green: 103.0/255.0, blue: 103.0/255.0, alpha: 1)
    }
    
    var highlightedBackgroundColor: UIColor {
        return UIColor(red: 145.0/255.0, green: 145.0/255.0, blue: 145.0/255.0, alpha: 1)
    }
    
}

