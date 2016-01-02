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
        return MyColors.invalidFormTextFieldIndicatorColor()
    }
}

struct FormTextFieldDefaultTheme: FormTextFieldTheme {
    
    var textColor: UIColor {
        return MyColors.whiteTextColor()
    }
    var placeholderColor: UIColor {
        return MyColors.formTextFieldPlaceholderColor()
    }
    var tintColor: UIColor {
        return placeholderColor
    }
    var leftViewTintColor: UIColor {
        return placeholderColor
    }
    var rightViewTintColor: UIColor {
        return placeholderColor
    }
    var backgroundColor: UIColor {
        return MyColors.formTextFieldDarkGrayBackgroundColor()
    }
    
    var highlightedBackgroundColor: UIColor {
        return MyColors.formTextFieldLightGrayBackgroundColor()
    }
    
}

