//
//  AppDelegate.swift
//  ViewControllerThinning
//
//  Created by Ilya Puchka on 26.09.15.
//  Copyright © 2015 Ilya Puchka. All rights reserved.
//

import UIKit
import Dip
import DipUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let container = DependencyContainer(assemblies: [UIComponents()]) { c in
        DependencyContainer.uiContainer = c
    }
}

