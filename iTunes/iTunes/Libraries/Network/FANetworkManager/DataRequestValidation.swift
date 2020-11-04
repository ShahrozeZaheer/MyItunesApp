//
//  DataRequestValidation.swift
//   
//
//  Created by Afroz on 14/09/2020.
//  Copyright © 2020 Afroz. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

extension DataRequest {
    public func validateResponse() -> Self {
        return validate { request, response, data in
            
            guard let _ = data else {
                let message = API.shouldShowDevLogs ? "Response Value from server is nil." : APIErrorMessage.internalServerError

                return .failure(NSError(errorMessage: message))
            }
            
            return .success(())
            
        }
    }
}
