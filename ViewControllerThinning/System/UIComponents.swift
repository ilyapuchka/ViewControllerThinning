//
//  UIComponents.swift
//  ViewControllerThinning
//
//  Created by Ilya Puchka on 25.10.15.
//  Copyright © 2015 Ilya Puchka. All rights reserved.
//

import Foundation
import Typhoon

class UIComponents: TyphoonAssembly {
    
    dynamic func authViewController() -> AnyObject {
        return TyphoonDefinition.withClass(ViewController.self) { def in
            def.injectProperty("nibName", with: "AuthView")
            def.injectProperty("formBehaviour")
            def.performAfterInjections("typhoonDidInject:") { method in
                method.injectParameterWith(self)
            }
        }
    }

    private(set) var networkComponents: NetworkComponents!

    dynamic func authFormBehaviour() -> AnyObject {
        return TyphoonDefinition.withClass(AuthFormBehaviour.self) {def in
            def.useInitializer("initWithAPIClient:") { method in
                method.injectParameterWith(self.networkComponents.apiClient())
            }
        }
    }
    
    dynamic func shakeAnimaton(view: UIView) -> AnyObject {
        return TyphoonDefinition.withClass(ShakeAnimationImp.self) { def in
            def.injectProperty("view", with: view)
        }
    }
    
}

extension ViewController {
    
    func typhoonDidInject(uiComponents: UIComponents) {
        formBehaviour?.userNameInput = authView.userNameInput
        formBehaviour?.passwordInput = authView.passwordInput
        authView.loginButton.addTarget(formBehaviour, action: "submitForm", forControlEvents: .TouchUpInside)
        authView.cancelButton.addTarget(formBehaviour, action: "cancelForm", forControlEvents: .TouchUpInside)
        
        authView.userNameInput.shakeAnimation = uiComponents.shakeAnimaton(authView.userNameInput) as! ShakeAnimationImp
        authView.passwordInput.shakeAnimation = uiComponents.shakeAnimaton(authView.passwordInput) as! ShakeAnimationImp
    }
}
