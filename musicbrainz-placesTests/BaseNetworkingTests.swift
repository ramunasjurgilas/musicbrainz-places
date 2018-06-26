//
//  BaseNetworkingTests.swift
//  musicbrainz-placesTests
//
//  Created by Ramunas Jurgilas on 2018-06-26.
//  Copyright © 2018 Ramūnas Jurgilas. All rights reserved.
//

import XCTest
@testable import musicbrainz_places

// Create a partial mock by subclassing the original class
class URLSessionDataTaskMock: URLSessionDataTask {
    private let closure: () -> Void
    init(closure: @escaping () -> Void) {
        self.closure = closure
    }
    
    // We override the 'resume' method and simply call our closure
    // instead of actually resuming any task.
    override func resume() {
        closure()
    }
}

class URLSessionMock: URLSession {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void

    var data: Data?
    var error: Error?
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let data = self.data
        let error = self.error
        return URLSessionDataTaskMock {
            completionHandler(data, nil, error)
        }
    }
}

class BaseNetworkingTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExecuteSuccesGeneric() {
        
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
