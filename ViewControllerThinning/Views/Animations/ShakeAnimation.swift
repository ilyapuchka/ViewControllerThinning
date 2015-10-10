//
//  ShakeAnimation.swift
//  ViewControllerThinning
//
//  Created by Ilya Puchka on 09.10.15.
//  Copyright © 2015 Ilya Puchka. All rights reserved.
//

import UIKit

@objc
protocol Animation {
    var duration: Double {get}
    var view: UIView? {get}
}

extension Animation {
    func play() {
        fatalError("Concrete instances of Animation protocol should provide implementation of this method.")
    }
}

@objc
protocol ShakeAnimation: Animation {
    var maxOffset: Double {get set}
    var keyPath: String {get set}
}

extension ShakeAnimation {
    func play() {
        guard let view = view else { return }
        
        let animation = CAKeyframeAnimation(keyPath: keyPath)
        animation.values = [0, maxOffset, -0.8 * maxOffset, 0.4 * maxOffset, 0]
        animation.keyTimes = [ 0, (1 / 6.0), (3 / 6.0), (5 / 6.0), 1 ]
        animation.duration = duration ?? view.implicitAnimationDuration
        animation.additive = true
        view.layer.addAnimation(animation, forKey: "shake")
    }
}

class ShakeAnimationImp: NSObject, ShakeAnimation {
    
    @IBInspectable
    var duration: Double = 0.2
    
    @IBInspectable
    var maxOffset: Double = 10
    
    @IBInspectable
    var keyPath: String = "position.x"
    
    @IBOutlet
    weak var view: UIView?
    
}

