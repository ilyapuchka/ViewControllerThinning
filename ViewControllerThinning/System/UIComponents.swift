//
//  UIComponents.swift
//  ViewControllerThinning
//
//  Created by Ilya Puchka on 25.10.15.
//  Copyright © 2015 Ilya Puchka. All rights reserved.
//

import Foundation
import Dip
import DipUI

class UIComponents: Assembly {
    
    let authViewController = AssemblyDefinitionOf(tag: "ViewController") { (_, _: Void) in ViewController() }
        .resolveDependencies { (c, vc) -> () in
            vc.animationsFactory = try c.resolve() as AnimationsFactory
    }
    
    let authFormBehaviour = AssemblyDefinitionOf() { (c, _: Void) in
        AuthFormBehaviourImp(apiClient: try c.resolve()) as AuthFormBehaviour
    }
    
    let animationFactory = AssemblyDefinitionOf() { (c, _: Void) in
        c as AnimationsFactory
    }
    
    let shakeAnimaton = AssemblyDefinitionOf() { (_, view: UIView) in
        ShakeAnimationImp(view: view) as ShakeAnimation
    }
    
    //Collaborating assemblies
    
    let networkComponents = NetworkComponents()
    
}

extension ViewController: StoryboardInstantiatable {}

extension DependencyContainer: AnimationsFactory {
    func shakeAnimation(view: UIView) -> ShakeAnimation {
        return try! self.resolve(withArguments: view) as ShakeAnimation
    }
}
