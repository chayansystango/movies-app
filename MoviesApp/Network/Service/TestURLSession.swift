//
//  TestURLSession.swift
//  MoviesApp
//
//  Created by Chayan on 11/02/19.
//  Copyright © 2019 Systango Technologies Pvt Ltd. All rights reserved.
//

import Foundation

class TestURLSession: URLSessionProtocol {
    
    var testDataTask = TestURLSessionDataTask()
    var testData: Data?
    var testError: Error?
    var testFailureStatusCode: Int = 400
    
    func successHttpURLResponse(request: URLRequest) -> URLResponse {
        return HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
    }
    
    func failureHttpURLResponse(request: URLRequest) -> URLResponse {
        return HTTPURLResponse(url: request.url!, statusCode: testFailureStatusCode, httpVersion: "HTTP/1.1", headerFields: nil)!
    }
    
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResponse) -> URLSessionDataTaskProtocol {
        var urlResponse: URLResponse!
        if testData != nil {
            urlResponse = successHttpURLResponse(request: request)
        } else {
            urlResponse = failureHttpURLResponse(request: request)
        }
        completionHandler(testData, urlResponse, testError)
        return testDataTask
    }
    
}

class TestURLSessionDataTask: URLSessionDataTaskProtocol {
    func resume() {}
}
