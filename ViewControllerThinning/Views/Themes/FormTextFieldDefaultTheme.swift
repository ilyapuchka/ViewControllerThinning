//
//  FormTextFieldDefaultTheme.swift
//  ViewControllerThinning
//
//  Created by Ilya Puchka on 17.09.15.
//  Copyright © 2015 Ilya Puchka. All rights reserved.
//

import UIKit

extension FormTextField {
    
    enum ThemeColorTag: ColorTag {
        case TintColor
        case TextColor
        case PlaceholderColor
        case LeftViewTintColor
        case RightViewTintColor
        case BackgroundColor
        case HighlightedBackgroundColor
        case InvalidIndicatorColor
    }
    
}

struct FormTextFieldDefaultTheme: ColorTheme {

    func colorForTag(tag: ColorTag) -> UIColor {
        if let tag = tag as? FormTextField.ThemeColorTag {
            switch tag {
            case .TextColor:
                return UIColor.whiteColor()
            case .PlaceholderColor:
                return UIColor.lightTextColor()
            case .LeftViewTintColor, .RightViewTintColor:
                return UIColor.lightTextColor()
            case .BackgroundColor:
                return UIColor(red: 103.0/255.0, green: 103.0/255.0, blue: 103.0/255.0, alpha: 1)
            case .HighlightedBackgroundColor:
                return UIColor(red: 145.0/255.0, green: 145.0/255.0, blue: 145.0/255.0, alpha: 1)
            case .InvalidIndicatorColor:
                return UIColor(red: 220.0/255.0, green: 0, blue: 0, alpha: 1)
            default: return mainColor
            }
        }
        else {
            return mainColor
        }
    }
}
