//
//  EndPoints.swift
//
//
//  Created by Afroz on 10/01/2020.
//  Copyright © 2020 Afroz. All rights reserved.
//

import Foundation

enum MyEndPoint: URLDirectable {
    
    case search(term: String, entity: String)
    
    func urlString() -> String {
     
        var endpoint = ""
        
        switch (self) {
                        
        case .search(let term, let entity):
            endpoint = "search?term=\(term)&entity=\(entity)"
            
        }
        
        return appConfigs.baseURL + endpoint
    }
}
