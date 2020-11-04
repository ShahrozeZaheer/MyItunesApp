//
//  MyNetworkManager.swift
//   
//
//  Created by Afroz on 10/01/2020.
//  Copyright © 2020 Afroz. All rights reserved.
//

import Foundation

let myNetworkManager = MyNetworkManager.shared

class MyNetworkManager: APIRoutable {

    var sessionManager: APISessionManager = APISessionManager()
    static let shared = MyNetworkManager()
    private init() {}
}
