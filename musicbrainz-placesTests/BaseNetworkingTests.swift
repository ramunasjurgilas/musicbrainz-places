//
//  BaseNetworkingTests.swift
//  musicbrainz-placesTests
//
//  Created by Ramunas Jurgilas on 2018-06-26.
//  Copyright © 2018 Ramūnas Jurgilas. All rights reserved.
//

import XCTest
@testable import musicbrainz_places

class BaseNetworkingTests: XCTestCase {
    
    func testExecuteGenericsSuccess() {
        let session = URLSessionMock()
        session.data = "PlaceQueryRespond".mockData()
        let request = BaseNetworking(endpoint: .place(query: "test", offset: 10, limit: 10), session: session)
        
        let successExpectation = expectation(description: "On success")
        request.execute(MBPlacesModel.self, onSuccess: { (result) in
            print(result)
            successExpectation.fulfill()
        }, onError: { (error) in
            
        })

        waitForExpectations(timeout: 0.5) { (error) in
            if let error = error {
                XCTFail("Success block was not executed. \(error)")
            }
        }
    }
    
    func testExecuteGenericsError() {
        let session = URLSessionMock()
        session.data = "CrapData".data(using: .utf8)
        let request = BaseNetworking(endpoint: .place(query: "test", offset: 10, limit: 10), session: session)
        
        let errorExpectation = expectation(description: "On error")
        request.execute(MBPlacesModel.self, onSuccess: { (data) in },
                        onError: { (error) in errorExpectation.fulfill() })
        
        waitForExpectations(timeout: 0.5) { (error) in
            if let error = error {
                XCTFail("Success block was not executed. \(error)")
            }
        }
    }

    
    
    
    
    
    
    func testRealExecute() {
        let request = BaseNetworking(endpoint: .place(query: "Studio", offset: 1, limit: 1))
        let successExpectation = expectation(description: "On success")

        request.execute(onSuccess: { (data) in
            successExpectation.fulfill()
        }, onError: { (error) in })
        
        waitForExpectations(timeout: 1.5) { (error) in
            if let error = error {
                XCTFail("Real success block was not executed. \(error)")
            }
        }
    }
    
    func testExecuteSucces() {
        let session = URLSessionMock()
        let testData = Data()
        session.data = testData
        let request = BaseNetworking(endpoint: .place(query: "test", offset: 10, limit: 10), session: session)

        let successExpectation = expectation(description: "On success")
        request.execute(onSuccess: { (data) in
            XCTAssert(data == testData, "On success data is not what expected.")
            successExpectation.fulfill()
        }, onError: { (error) in })

        waitForExpectations(timeout: 0.5) { (error) in
            if let error = error {
                XCTFail("Success block was not executed. \(error)")
            }
        }
    }

    func testExecuteError() {
        let session = URLSessionMock()
        let testError = NSError(domain: "test.error", code: -23, userInfo: nil)
        session.error = testError
        let request = BaseNetworking(endpoint: .place(query: "test", offset: 10, limit: 10), session: session)
        
        let errorExpectation = expectation(description: "On success")
        request.execute(onSuccess: { (data) in },
                        onError: { XCTAssert(($0 as NSError) == testError, "On error is not what expected.")
                            errorExpectation.fulfill() })
        
        waitForExpectations(timeout: 0.5) { (error) in
            if let error = error {
                XCTFail("Success block was not executed. \(error)")
            }
        }
    }

}
