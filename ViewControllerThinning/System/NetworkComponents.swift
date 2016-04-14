//
//  NetworkComponents.swift
//  ViewControllerThinning
//
//  Created by Ilya Puchka on 25.10.15.
//  Copyright © 2015 Ilya Puchka. All rights reserved.
//

import Foundation
import SwiftNetworking
import Dip

class NetworkComponents: Assembly {
    
    let apiClient = AssemblyDefinitionOf() { (_, _: Void) in
        APIClient(baseURL: NSURL(string: "http://localhost:2368")!) as GhostApiClient
    }
    
}


