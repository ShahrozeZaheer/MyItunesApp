//
//  BaseResponseModel.swift
//   
//
//  Created by Afroz on 27/02/2019.
//  Copyright © 2019 Etisalat. All rights reserved.
//

import UIKit
import ObjectMapper

class BaseResponseModel: Mappable {
    // MARK: - Model Keys
    
    enum CodingKeys: String {
        case resultCount
    }
    
    // MARK: - Model Variables
    
    var resultCount: Int?
    
    // MARK: - Inilizers
    
    public required init?(map: Map) {
        mapping(map: map)
    }
    
    // MARK: - Model mapping
    
    public func mapping(map: Map) {
        resultCount <- map[CodingKeys.resultCount.rawValue]
    }
    
    // MARK: - Model dictionary
    
    open func dictionaryRepresentation() -> [String: AnyObject] {
        return toJSON() as [String: AnyObject]
    }
}
