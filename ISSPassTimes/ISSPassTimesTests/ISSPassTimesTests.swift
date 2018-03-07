//
//  ISSPassTimesTests.swift
//  ISSPassTimesTests
//
//  Created by Mayank Goyal on 06/03/18.
//  Copyright © 2018 Mayank Goyal. All rights reserved.
//

import XCTest
@testable import ISSPassTimes

class ISSPassTimesTests: XCTestCase {
    
    var passTimeVC: PassTimeViewController?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "passTimeViewController") as? PassTimeViewController {
            passTimeVC = vc
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testISSPassTimeService() {
        if let vc = passTimeVC {
            let expectation = self.expectation(description: "\(#function)")
            vc.getIssPaaTime {
                expectation.fulfill()
            }
            
            self.waitForExpectations(timeout: 10) { (error) -> Void in
                XCTAssertNil(error, "\(error.debugDescription)")
            }
        }
    }
    
    func testLocationEnableFunction() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        if let vc = passTimeVC {
            _ = vc.view
            let expectation = self.expectation(description: "\(#function)")
            vc.viewDidLoad()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                expectation.fulfill()
            }
            self.waitForExpectations(timeout: 10) { (error) -> Void in
                XCTAssertNil(error, "\(error.debugDescription)")
            }
        }
    }
    
    func testWebServiceFunction() {
        let expectation = self.expectation(description: "\(#function)")
        WebLayerManager.sharedInstance.executeService(urlPath: "https://goole.com", httpMethodType: "POST", body: "body") { (result, error) in
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 10) { (error) -> Void in
            XCTAssertNil(error, "\(error.debugDescription)")
        }
    }
    
    func testErrorFunction() {
        let error = NSError(domain: "", code: -1009, userInfo: nil)
        _ = messageFromError(error)
    }
}
