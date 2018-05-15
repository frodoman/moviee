//
//  URLTest.swift
//  MovieeTests
//
//  Created by Xinghou Liu on 15/05/2018.
//  Copyright © 2018 Xmart Soft Ltd. All rights reserved.
//

import XCTest

class URLTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testNowPlayingUrl(){
        let url = URL.init(string: ConstUrlTextNowPlaying)
        
        let data = try? Data.init(contentsOf: url!)
        
        // Need to parse the data into JSON object to valify if
        // it contians a list of movie objects
        
        XCTAssertTrue(data != nil, "URL for now playing has no data...")
        
    }
    
    // TODO...
    func testMovieDetailUrl()
    {
        
    }
    
    func testCollectionDetailUrl()
    {
        
    }
}
