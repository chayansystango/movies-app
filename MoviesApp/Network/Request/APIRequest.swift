//
//  APIRequest.swift
//  MoviesApp
//
//  Created by Chayan on 24/01/19.
//  Copyright © 2019 Systango Technologies Pvt Ltd. All rights reserved.
//

import UIKit

class APIRequest {
    
    static func callAPIWith(endPoint: String, methodType: HTTPMethod, parameters: [String: Any]?, completionHandler: @escaping (APIResponse?) -> ()) {
        
        // Check API endpoint is valid
        guard let endpointUrl = URL(string: endPoint) else {
            completionHandler(getAPIResponseWithErrorMessage(errorMessage: ErrorMessage.kInvalidURL))
            return
        }
        
        var request = URLRequest(url: endpointUrl)
        let data = NSKeyedArchiver.archivedData(withRootObject: parameters ?? [:])
        request.httpBody = data
        request.httpMethod = methodType.rawValue
        request.cachePolicy = .reloadIgnoringCacheData
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                guard let responseData = data else {
                    completionHandler(getAPIResponseWithErrorMessage(errorMessage: ErrorMessage.kNoData))
                    return
                }
                guard let json = try JSONSerialization.jsonObject(with: responseData, options: []) as? NSDictionary else {
                    completionHandler(getAPIResponseWithErrorMessage(errorMessage: ErrorMessage.kConversionFailed))
                    return
                }
                if let httpResponse = response as? HTTPURLResponse {
                   completionHandler(getAPIResponseWithBodyAndStatusCodes(json: json, statusCode: httpResponse.statusCode))
                }
            } catch let error as NSError {
                completionHandler(getAPIResponseWithErrorMessage(errorMessage: error.debugDescription))
            }
        }
        task.resume()
    }
    
    class func getAPIResponseWithErrorMessage(errorMessage: String) -> APIResponse {
        let apiResponse = APIResponse(body: nil, header: nil, statusCode: nil, errorMessage: errorMessage)
        return apiResponse
    }
    
    class func getAPIResponseWithBodyAndStatusCodes(json: Any, statusCode: Int) -> APIResponse {
        if let jsonResponse = json as? [String : Any] {
            if 200 ... 299 ~= statusCode {
                let apiResponse = APIResponse(body: jsonResponse, header: nil, statusCode: statusCode, errorMessage: nil)
                return apiResponse
            } else {
                if let errorMessage = jsonResponse["message"] as? String {
                    let apiResponse = APIResponse(body: jsonResponse, header: nil, statusCode: statusCode, errorMessage: errorMessage)
                    return apiResponse
                } else {
                    let apiResponse = APIResponse(body: jsonResponse, header: nil, statusCode: statusCode, errorMessage: ErrorMessage.kInvalidResponse)
                    return apiResponse
                }
            }
        } else {
            let apiResponse = APIResponse(body: nil, header: nil, statusCode: nil, errorMessage: ErrorMessage.kInvalidJSON)
            return apiResponse
        }
    }
}
