//
//  BackgroundHighlightableView.swift
//  ViewControllerThinning
//
//  Created by Ilya Puchka on 09.10.15.
//  Copyright © 2015 Ilya Puchka. All rights reserved.
//

import UIKit

protocol BackgroundHighlightableView: class {
    var backgroundColor: UIColor? {get set}
    var backgroundColorForHighlightedState: UIColor? {get}
    var backgroundColorForNormalState: UIColor? {get}
    
    var highlighted: Bool {get set}
    func setHighlighted(highlighted: Bool, animated: Bool)
    func backgroundColor(highlighted: Bool) -> UIColor?
}

extension BackgroundHighlightableView where Self: UIView {
    
    func setHighlighted(highlighted: Bool, animated: Bool) {
        let view = self as UIView
        guard backgroundColorForHighlightedState != nil &&
            view.backgroundColor != nil else {
                return
        }
        changeAnimated(true, options: [.BeginFromCurrentState]) {
            view.backgroundColor = self.backgroundColor(highlighted)
        }
    }
    
    func backgroundColor(highlighted: Bool) -> UIColor? {
        return highlighted ? backgroundColorForHighlightedState : backgroundColorForNormalState
    }
    
}

