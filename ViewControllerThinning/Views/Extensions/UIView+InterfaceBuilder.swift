//
//  UIView+InterfaceBuilder.swift
//  ViewControllerThinning
//
//  Created by Ilya Puchka on 26.09.15.
//  Copyright © 2015 Ilya Puchka. All rights reserved.
//

import UIKit

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            clipsToBounds = newValue != 0
            layer.cornerRadius = newValue
        }
    }
    
}