//
//  AppDelegate.swift
//  ViewControllerThinning
//
//  Created by Ilya Puchka on 26.09.15.
//  Copyright © 2015 Ilya Puchka. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

}

extension AppDelegate {
    func initialAssemblies() -> [AnyClass] {
        return [NetworkComponents.self, UIComponents.self]
    }
}

