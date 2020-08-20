//
//  ServiceManagerTests.swift
//  MusicAppTests
//
//  Created by Joel on 8/20/20.
//  Copyright © 2020 Joel. All rights reserved.
//

import XCTest
@testable import MusicApp

class ServiceTests: XCTestCase {
    
    var httpClient: ServiceManager!
    let session = MockURLSession()
    
    override func setUp() {
        super.setUp()
        httpClient = ServiceManager(session: session)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_get_request_with_URL() {

        let url = "https://mockurl"
        
        httpClient.getTopAlbums(url: url, completion: {  (success, response) in
        })
        
        XCTAssert(session.lastURL?.absoluteString == url)
        
    }
    
    func test_get_resume_called() {
        
        let dataTask = MockURLSessionDataTask()
        session.nextDataTask = dataTask
        
       let url = "https://mockurl"
        
        httpClient.getTopAlbums(url: url, completion: {  (success, response) in
        })
        
        XCTAssert(dataTask.resumeWasCalled)
    }
    
    func test_get_should_return_data() {
        let expectedData = "{}".data(using: .utf8)
        
        session.nextData = expectedData
        
        var actualData: AlbumFeed?
        let url = "https://mockurl"
        
        httpClient.getTopAlbums(url: url) { (data, error) in
            actualData = data
        }
        XCTAssertNotNil(actualData)
    }
    
}
