//
//  API.swift
//   
//
//  Created by Afroz on 10/01/2020.
//  Copyright © 2020 Afroz. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

public protocol APIRoutable {

    var sessionManager: APISessionManager {get}  //  Session manager must be provided by interface conforming the protocol
    
    //  Gives you simple Alamofire DataResponse<Any>.value
    func request(_ api: API, completion: @escaping API.Completion<Any?>.simple) -> Request?
    
    //  Gives you simple Alamofire DataResponse<Any>.value parsed in T?
    func requestObject<T: Mappable>(_ api: API, mapperType: T.Type, completion: @escaping API.Completion<T>.object) -> Request?

    //  Gives you simple Alamofire DataResponse<Any>.value parsed in [T]? array
    func requestList<T: Mappable>(_ api: API, mapperType: T.Type, parsingLevel: String, completion: @escaping API.Completion<T>.list) -> Request?

    //  Interface conforming should provide implementation of it
    func getHeaders(_ authorized: Bool, _ additionalHeaders: [String: String]?) -> [String : String]?

    //  Response validation for failure blocks
    func validate(dataResponse: AFDataResponse<Any>, with completion: @escaping API.Completion<Any?>.simple)
    func errorMessageFromAPIError(error: Error) -> String
}

public extension APIRoutable {
    
    @discardableResult
    func request(_ api: API, completion: @escaping API.Completion<Any?>.simple) -> Request? {

        if let params = api.parameters { devLog("💛💛\(params)💛💛") }
        let urlString = api.endPoint.urlString()
        
        
        var httpHeaders: HTTPHeaders? = nil
        if let headers = getHeaders(api.isAuthorized, api.additionalHeaders) {
            httpHeaders = HTTPHeaders(headers)
        }
        
         
        let request = sessionManager.request(urlString, method: api.method, parameters: api.parameters, encoding: api.encoding, headers: httpHeaders, interceptor: nil, requestModifier: nil).responseJSON { (dataResponse) in
            self.validate(dataResponse: dataResponse, with: completion)
        }
        
        return request
        
    }

    func validate(dataResponse: AFDataResponse<Any>, with completion: @escaping API.Completion<Any?>.simple) {

        if let error = dataResponse.error {
            let errorMessage = errorMessageFromAPIError(error: error)
            if !errorMessage.isEmpty {
                completion(.failure(NSError(errorMessage: errorMessage, code: dataResponse.response?.statusCode)))
                return
            }
        }
        guard let value = dataResponse.value else {
            let message = API.shouldShowDevLogs ? "Response Value from server is nil." : APIErrorMessage.internalServerError
            return completion(.failure(NSError(errorMessage: message, code: APIErrorCodes.responseNil)))
            
        }
        completion(.success(value))
    }
    
    @discardableResult
    func requestObject<T: Mappable>(_ api: API, mapperType: T.Type, completion: @escaping API.Completion<T>.object) -> Request? {

        let alamofireRequest = request(api) { (response) in
            switch response {
            case .success(let result):
                if let resultValue = result as? [String: Any] {
                    if let resultObject = Mapper<T>(context: api.endPoint).map(JSON: resultValue) {
                        completion(.success(resultObject))
                        return
                    }
                }
                else if let resultValue = result as? String {
                    if let resultObject = T(JSONString: resultValue) {
                        completion(.success(resultObject))
                        return
                    }
                }

                let message = API.shouldShowDevLogs ? APIErrorMessage.responseSerializationFailed : "Can't parse JSON because its not a JSON Object."
                completion(.failure(NSError(errorMessage: message)))
                break
            case .failure(let error):
                completion(.failure(error))
                break
            }
        }
        return alamofireRequest
    }

    @discardableResult
    func requestList<T: Mappable>(_ api: API, mapperType: T.Type, parsingLevel: String, completion: @escaping API.Completion<T>.list) -> Request? {

        let alamofireRequest = self.request(api) { (response) in
            switch response {
            case .success(let result):
                if let resultValue = result as? [[String: Any]] {
                    let resultList = Mapper<T>(context: api.endPoint).mapArray(JSONArray: resultValue)
                    completion(.success(resultList))
                    return
                }
                else if let resultValue = result as? [String: Any] {
                    
                    let levels = parsingLevel.components(separatedBy: ".")
                    let initialLevels = levels
                    _ = initialLevels.dropLast()
                    var value = resultValue
                    for level in levels {
                        if let validatedValue = value[level] as? [String: Any] {
                            value = validatedValue
                        }
                        else { break }
                    }
                    if let lastLeve = levels.last {
                        if let array = value[lastLeve] as? [[String: Any]] {
                            let resultList = Mapper<T>(context: api.endPoint).mapArray(JSONArray: array)
                            completion(.success(resultList))
                            return
                        }
                    }
                }
                let message = API.shouldShowDevLogs ? APIErrorMessage.responseSerializationFailed : "Can't parse JSON because its not a JSON Array."
                completion(.failure(NSError(errorMessage: message)))
                break
            case .failure(let error):
                completion(.failure(error))
                break
            }
        }
        return alamofireRequest
    }

    func getHeaders(_ authorized: Bool, _ additionalHeaders: [String: String]?) -> [String : String]? {
        
        //  Below is an example to use it. Override the protocol shared implementation into your interface conforming this protocol.

        
        var headers = [String: String]()
        headers["Content-Type"] = "application/json"
        headers["Connection"] = "keep-alive"
        if authorized {
            headers["token"] = ""
        }

        if let addtionalHeaderFields = additionalHeaders {
            addtionalHeaderFields.forEach { (key, value) in
                headers[key] = value
            }
        }
        return headers
    }
}


