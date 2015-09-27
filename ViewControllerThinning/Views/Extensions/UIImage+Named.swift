//
//  UIImage+Named.swift
//  ViewControllerThinning
//
//  Created by Ilya Puchka on 15.09.15.
//  Copyright © 2015 Ilya Puchka. All rights reserved.
//

import UIKit

extension UIImage {
    
    enum AssetIdentifier: String {
        case InputEmailIcon
        case InputPasswordIcon
    }
    
    convenience init!(_ assetIdentifier: AssetIdentifier) {
        self.init(named: assetIdentifier.rawValue)
    }

}