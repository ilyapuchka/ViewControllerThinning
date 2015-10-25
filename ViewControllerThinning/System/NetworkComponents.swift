//
//  NetworkComponents.swift
//  ViewControllerThinning
//
//  Created by Ilya Puchka on 25.10.15.
//  Copyright © 2015 Ilya Puchka. All rights reserved.
//

import Foundation
import SwiftNetworking
import Typhoon

@objc
public class APIClientBox: NSObject {
    let unboxed: APIClient
    dynamic init(_ boxed: AnyObject) {
        unboxed = boxed as! APIClient
    }
}

class NetworkComponents: TyphoonAssembly {
    
    dynamic func apiClient() -> AnyObject {
        return TyphoonDefinition.withClass(APIClientBox.self) { (def: TyphoonDefinition!) in
            def.useInitializer("init:") { (initializer: TyphoonMethod!) in
                initializer.injectParameterWith(NetworkComponents.apiClientInstance)
            }
        }
    }
    
    private static let apiClientInstance: APIClient = {
        let host = "http://localhost:2368"
        let client = APIClient(baseURL: NSURL(string: host)!)
        return client
        }()
    
}


