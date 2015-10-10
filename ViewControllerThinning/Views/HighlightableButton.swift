//
//  HighlightableButton.swift
//  ViewControllerThinning
//
//  Created by Ilya Puchka on 10.10.15.
//  Copyright © 2015 Ilya Puchka. All rights reserved.
//

import UIKit

class HighlightableButton: UIButton, BackgroundHighlightableView {
    
    @IBInspectable
    var backgroundColorForHighlightedState: UIColor?
    
    var backgroundColorForNormalState: UIColor?
    
    override var backgroundColor: UIColor? {
        didSet {
            backgroundColorForNormalState = backgroundColorForNormalState ?? backgroundColor
        }
    }
    
    override var highlighted: Bool {
        willSet {
            setHighlighted(newValue, animated: true)
        }
    }
    
}

