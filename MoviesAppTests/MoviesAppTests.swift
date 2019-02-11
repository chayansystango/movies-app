//
//  MoviesAppTests.swift
//  MoviesAppTests
//
//  Created by Chayan on 11/02/19.
//  Copyright © 2019 Systango Technologies Pvt Ltd. All rights reserved.
//

import XCTest
@testable import MoviesApp

class MoviesAppTests: XCTestCase {
    
    var manager: Manager<MoviesApi>!
    let session = TestURLSession()
    let movieDetailViewModel = MovieDetailViewModel()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        manager = Manager<MoviesApi>(session: session)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testYouTubeVideoIdGenerationSuccess() {
        let testYouTubeLinks = ["youtube.com/v/oHg5SJYRHA0",
                                "youtube.com/?v=oHg5SJYRHA0",
                                "youtube.com/watch?v=oHg5SJYRHA0",
                                "youtu.be/oHg5SJYRHA0",
                                "youtube.com/embed/oHg5SJYRHA0",
                                "http://youtube.com/v/oHg5SJYRHA0",
                                "http://www.youtube.com/v/oHg5SJYRHA0",
                                "https://www.youtube.com/v/oHg5SJYRHA0",
                                "youtube.com/watch?v=oHg5SJYRHA0&wtv=wtv",
                                "http://www.youtube.com/watch?dev=inprogress&v=oHg5SJYRHA0&feature=related",
                                "https://m.youtube.com/watch?v=oHg5SJYRHA0",
                                "www.facebook.com?wtv=youtube.com/v/oHg5SJYRHA0"]
        
        for youTubeLink in testYouTubeLinks {
            let videoId = movieDetailViewModel.getVideoIdFrom(youTubeLink: youTubeLink)
            XCTAssertEqual(videoId, "oHg5SJYRHA0")
        }
    }
    
    func testYouTubeVideoIdGenerationFailure() {
        let testYouTubeLinks = ["www.google.com/oHg5SJYRHA0",
                                "google.com/oHg5SJYRHA0",
                                "facebook.com/oHg5SJYRHA0",
                                "AnyString",
                                ""]
        
        for youTubeLink in testYouTubeLinks {
            let videoId = movieDetailViewModel.getVideoIdFrom(youTubeLink: youTubeLink)
            XCTAssertEqual(videoId, "")
        }
    }
    
    // MARK: - Network Tests

    func testGetMoviesSuccess() {
        let path = Bundle(for: type(of: self)).path(forResource: "GetMoviesSuccess", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        session.testData = data
        
        manager.request(.getList) { (result) in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.statusCode, 200)
                XCTAssertNotNil(data)
            case .failure( _):
                XCTFail()
            }
        }
    }
    
    func testGetMoviesFailure() {
        
        let testFailureArray: [(code: Int, message: String)] =
            [(code: 401, message: ErrorMessage.kAuthenticationError),
             (code: 501, message: ErrorMessage.kBadRequest),
             (code: 600, message: ErrorMessage.kOutdatedRequest),
             (code: 301, message: ErrorMessage.kRequestFailed),
             (code: 403, message: ErrorMessage.kAuthenticationError)]
        
        for failure in testFailureArray {
            session.testFailureStatusCode = failure.code
            
            manager.request(.getList) { (result) in
                switch result {
                case .success( _):
                    XCTFail()
                case .failure(let failureString):
                    XCTAssertEqual(failureString, failure.message)
                }
            }
        }
        
    }

}
