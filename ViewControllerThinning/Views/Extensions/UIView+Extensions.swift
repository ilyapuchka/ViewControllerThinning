//
//  UIView+Extensions.swift
//  ViewControllerThinning
//
//  Created by Ilya Puchka on 14.09.15.
//  Copyright © 2015 Ilya Puchka. All rights reserved.
//

import UIKit

extension UIView {
    
    class func animateWithDuration(duration: NSTimeInterval = 0, delay: NSTimeInterval = 0, options: UIViewAnimationOptions = [], animations: () -> Void) {
        animateWithDuration(duration, delay: delay, options: options, animations: animations, completion: nil)
    }

    func changeAnimated(animated: Bool, delay: NSTimeInterval = 0, options: UIViewAnimationOptions = [], changes: () -> Void) {
        UIView.animateWithDuration(animated ? implicitAnimationDuration : 0, delay: delay, options: options, animations: changes)
    }
}