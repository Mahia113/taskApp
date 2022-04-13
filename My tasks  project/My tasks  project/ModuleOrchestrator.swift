//
//  ModuleOrchestrator.swift
//  My tasks  project
//
//  Created by Anzen on 13/04/22.
//

import Foundation
import Combine

public struct ModuleOrchestrator {
    
    init() {}
    
    public func NetworkManager() -> NetworkManager {
        let networkManager = My_tasks__project.NetworkManager(client: self)
        return networkManager
    }
    
    //TO-DO
    // ADD FUNCTION TO RETURN ANOTHER MODULES LIKE PERSISTENCE O MANAGER FOR STUFF
    
}
