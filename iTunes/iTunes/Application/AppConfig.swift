//
//  AppConfig.swift
//  iTunes
//
//  Created by Afroz on 04/11/2020.
//

import UIKit


// MARK:- App Configurations

let appConfigs = AppConfig.sharedInstance

class AppConfig {
    
    // MARK:- Static Properties
    
    static let sharedInstance = AppConfig()
    
    
    // MARK:- Class Properties
    
    var baseURLDomain: String {
        get {
            return "itunes.apple.com"
        }
    }
    
    
    var baseURL: String {
        get {
            return "https://\(baseURLDomain)/"
        }
    }
    
    
}
