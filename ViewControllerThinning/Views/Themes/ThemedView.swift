//
//  ThemedView.swift
//  ViewControllerThinning
//
//  Created by Ilya Puchka on 17.09.15.
//  Copyright © 2015 Ilya Puchka. All rights reserved.
//

import UIKit

protocol ColorTag {}

protocol ColorTheme {
    func colorForTag(tag: ColorTag) -> UIColor
    var mainColor: UIColor {get}
}

extension ColorTheme {
    var mainColor: UIColor {
        return UIColor.whiteColor()
    }
}

protocol ThemedView: class {
    var theme: ColorTheme {get set}
    func updateAppearance()
}

