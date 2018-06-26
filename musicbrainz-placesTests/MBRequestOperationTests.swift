//
//  MBRequestOperationTests.swift
//  musicbrainz-placesTests
//
//  Created by Ramunas Jurgilas on 2018-06-26.
//  Copyright © 2018 Ramūnas Jurgilas. All rights reserved.
//

import XCTest

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

class MBRequestOperationTests: XCTestCase {
    let queue = OperationQueue()

    func testRequestOperation() {
        let session = URLSessionMock()
        session.data = "PlaceQueryRespond".mockData()

        let networking = BaseNetworking(endpoint: .place(query: "test", offset: 10, limit: 10), session: session)
        let operation = MBRequestOperation<MBPlacesModel>(networking: networking)
        let expect = expectation(description: "Completed")
        operation.completionBlock = {
            expect.fulfill()
        }
        
        queue.addOperations([operation], waitUntilFinished: true)
        waitForExpectations(timeout: 1) { (error) in
            if let error = error {
                XCTFail("Not all opertions were completed. \(error)")
            }
        }
    }
    /*
    func testExample() {
        let session = URLSessionMock()
        session.data = "PlaceQueryRespond".mockData()
        var operations: [Operation] = []
        let range = 0...10
        var completedOperationCount = 0
        let expect = expectation(description: "Completed")
        range.forEach {_ in
            let networking = BaseNetworking(endpoint: .place(query: "test", offset: 10, limit: 10), session: session)
            let operation = MBRequestOperation<MBPlacesModel>(networking: networking)
            operations.append(operation)
            operation.completionBlock = { [unowned operation] in
                completedOperationCount += 1
                print(operation.error)
                print(operation.result)
                print(range.count)
                print(completedOperationCount)
                if completedOperationCount == range.count {
                    expect.fulfill()
                }
            }
        }
        queue.addOperations(operations, waitUntilFinished: true)
        print("completeddddddd")
        
        waitForExpectations(timeout: 1) { (error) in
            if let error = error {
                XCTFail("Not all opertions were completed. \(error)")
            }
        }
    }
    */
}
