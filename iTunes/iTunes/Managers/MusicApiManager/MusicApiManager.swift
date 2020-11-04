//
//  MusicApiManager.swift
//  iTunes
//
//  Created by Afroz on 04/11/2020.
//

import UIKit
import Alamofire


class MusicApiManager {
    
    func getAllCountries(params: [String: Any]?, completion: @escaping (_ musicList: [Music]?) -> Void, failure: @escaping (_ error: Error) -> Void) {
        
        let api = API(method: .get, endPoint: MyEndPoint.search(term: params?["term"] as! String, entity: params?["entity"] as! String), isAuthorized: false, parameters: nil)

        myNetworkManager.requestObject(api, mapperType: MusicResponseModel.self) { (result) in
            switch result {

            case .success(let value):
                if let music = value.results {
                    completion(music)
                } else {
                    completion(nil)
                }
                break

            case .failure(let error):
                failure(error)
                break

            }
        }
  
        
     
        
    }
}
