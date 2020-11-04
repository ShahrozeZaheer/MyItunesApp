//
//  APISessionManager.swift
//   
//
//  Created by Afroz on 10/01/2020.
//  Copyright © 2020 Afroz. All rights reserved.
//

import Foundation
import Alamofire

public class APISessionManager: Session {

    public override func request(_ convertible: URLRequestConvertible, interceptor: RequestInterceptor? = nil) -> DataRequest {
        let request = super.request(convertible)
        request.responseString { (responseString) in
            if let url = convertible.urlRequest?.url { devLog("\n💚💚\n\(url)\n💚💚\n") }
            devLog("❤️❤️❤️\(responseString)\n❤️❤️❤️\n")
        }
        return request
    }
    
    public override func request(_ convertible: URLConvertible, method: HTTPMethod = .get, parameters: Parameters? = nil, encoding: ParameterEncoding = URLEncoding.default, headers: HTTPHeaders? = nil, interceptor: RequestInterceptor? = nil, requestModifier: Session.RequestModifier? = nil) -> DataRequest {
        
        let request = super.request(convertible)
        request.responseString { (responseString) in
            if let url = try? convertible.asURL() { devLog("\n💚💚\n\(url)\n💚💚\n") }
            devLog("❤️❤️❤️\(responseString)\n❤️❤️❤️\n")
        }
        return request
    }
    
}
