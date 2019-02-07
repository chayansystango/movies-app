//
//  RequestManager.swift
//  MoviesApp
//
//  Created by Chayan on 07/02/19.
//  Copyright © 2019 Systango Technologies Pvt Ltd. All rights reserved.
//

import Foundation

typealias APICompletion = (Result) -> ()

protocol RequestManager {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint, completion: @escaping APICompletion)
}

class Manager<EndPoint: EndPointType>: RequestManager {
    private var task: URLSessionTask?
    
    func request(_ route: EndPoint, completion: @escaping APICompletion) {
        let session = URLSession.shared
        if let request = buildRequest(from: route) {
            task = session.dataTask(with: request, completionHandler: { data, response, error in
                if error != nil {
                    completion(.failure("Please check your network connection."))
                }
                
                if let response = response as? HTTPURLResponse {
                    let result = self.handleNetworkResponse(data, response)
                    completion(result)
                }
            })
            self.task?.resume()
        }
    }
    
    fileprivate func buildRequest(from route: EndPoint) -> URLRequest? {
        
        // Check API endpoint is valid
        guard let endpointUrl = URL(string: URLConstant.baseLiveURL + route.module + route.path) else {
            return nil
        }
        
        var request = URLRequest(url: endpointUrl,
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 30.0)
        
        request.httpMethod = route.httpMethod.rawValue
        switch route.task {
        case .request:
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
        case .requestParameters(let parameters):
            self.configureParameters(parameters: parameters, request: &request)
            
        case .requestParametersAndHeaders(let parameters, let additionalHeaders):
            self.addAdditionalHeaders(additionalHeaders, request: &request)
            self.configureParameters(parameters: parameters, request: &request)
        }
        return request
    }
    
    fileprivate func configureParameters(parameters: [String: Any]?, request: inout URLRequest) {
        let data = NSKeyedArchiver.archivedData(withRootObject: parameters ?? [:])
        request.httpBody = data
    }
    
    fileprivate func addAdditionalHeaders(_ additionalHeaders: [String: String]?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
    fileprivate func handleNetworkResponse(_ data: Data?, _ response: HTTPURLResponse) -> Result {
        switch response.statusCode {
        case 200...299: return .success(getAPIResponseFor(data, response))
        case 401...500: return .failure(ErrorMessage.kAuthenticationError)
        case 501...599: return .failure(ErrorMessage.kBadRequest)
        case 600: return .failure(ErrorMessage.kOutdatedRequest)
        default: return .failure(ErrorMessage.kRequestFailed)
        }
    }
    
    fileprivate func getAPIResponseFor(_ data: Data?, _ response: HTTPURLResponse) -> APIResponse {
        do {
            guard let responseData = data else {
                return getAPIResponseWithErrorMessage(errorMessage: ErrorMessage.kNoData)
            }
            guard let json = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any] else {
                return getAPIResponseWithErrorMessage(errorMessage: ErrorMessage.kConversionFailed)
            }
            return APIResponse(body: json, header: nil, statusCode: response.statusCode, errorMessage: nil)
        } catch let error as NSError {
            return getAPIResponseWithErrorMessage(errorMessage: error.debugDescription)
        }
    }
    
    fileprivate func getAPIResponseWithErrorMessage(errorMessage: String) -> APIResponse {
        let apiResponse = APIResponse(body: nil, header: nil, statusCode: nil, errorMessage: errorMessage)
        return apiResponse
    }
    
}

