//
//  UIComponents.swift
//  ViewControllerThinning
//
//  Created by Ilya Puchka on 25.10.15.
//  Copyright © 2015 Ilya Puchka. All rights reserved.
//

import Foundation
import Dip

class UIComponents: Assembly {
    
    let authViewController = AssemblyDefinitionOf<ViewController>(tag: "ViewController") { _ in
        IBDefintion().resolveDependencies { (c, vc) -> () in
            vc.animationsFactory = try! c.resolve() as AnimationsFactory
        }
    }

    let authFormBehaviour = AssemblyDefinitionOf<AuthFormBehaviour> { (container: DependencyContainer) in
        container.register() { AuthFormBehaviourImp(apiClient: try! container.resolve()) as AuthFormBehaviour }
    }
    
    let animationFactory = AssemblyDefinitionOf<AnimationsFactory> { (container: DependencyContainer) in
        DefinitionOf(scope: .Prototype) { [unowned container] in
            container as AnimationsFactory
        }
    }
    
    let shakeAnimaton = AssemblyDefinitionOf<ShakeAnimation> { _ in
        DefinitionOf(scope: .Prototype) { (view: UIView) in
            ShakeAnimationImp(view: view) as ShakeAnimation
        }
    }
    
    //Collaborating assemblies
    
    let networkComponents = NetworkComponents()
    
}

extension DependencyContainer: AnimationsFactory {
    func shakeAnimation(view: UIView) -> ShakeAnimation {
        return try! self.resolve(withArguments: view) as ShakeAnimation
    }
}
