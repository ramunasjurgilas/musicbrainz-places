//
//  MBPlaceBatchRequestTests.swift
//  musicbrainz-placesTests
//
//  Created by Ramunas Jurgilas on 2018-06-27.
//  Copyright © 2018 Ramūnas Jurgilas. All rights reserved.
//

import XCTest

class MBPlaceBatchRequestTests: XCTestCase, MBPlaceBatchRequestDelegate {
    var places: [MBPlaceModel] = []
    var expect: XCTestExpectation!
    
    func testFetchUsingQueryAndLimit() {
        let batch = MBPlaceBatchRequest()
        let session = URLSessionMock()
        expect = expectation(description: "Batch fetch")
        session.data = "PlaceQueryRespond".mockData()
        batch.session = session
        batch.delegate = self
        batch.fetchUsing("NA", limit: 20)
        
        waitForExpectations(timeout: 2) { (error) in
            if let error = error {
                XCTFail("Did failed batch fetched. \(error)")
                return
            }
            XCTAssert(self.places.count > 0, "Places count must be more than 0.")
            XCTAssert(self.places.count == 1, "Missing or to much places were found.")
        }
    }
    
    func testExample() {
        expect = expectation(description: "Batch fetch")
        let batch = MBPlaceBatchRequest()
        batch.delegate = self
        batch.requests = baseNetworking()
        batch.fetch()
        
        waitForExpectations(timeout: 2) { (error) in
            if let error = error {
                XCTFail("Did failed batch fetched. \(error)")
                return
            }
            XCTAssert(self.places.count > 0, "Places count must be more than 0.")
            XCTAssert(self.places.count == batch.requests.count, "Missing or to much places were found.")
        }
    }
    
    func didFetch(places: [MBPlaceModel]) {
        self.places += places
    }
    
    func didCompleteFetching(_ error: Error?) {
        expect.fulfill()
    }

    private func baseNetworking() -> [BaseNetworking] {
        let session = URLSessionMock()
        session.data = "PlaceQueryRespond".mockData()
        let limit = 20
        var result: [BaseNetworking] = []
        for offset in stride(from: 0, to: 100, by: limit) {
            print("Offset: \(offset) limit: \(limit)")
            let endpoint = MusicBrainzEndpoint.place(query: "Studio", offset: offset, limit: limit)
            let request = BaseNetworking(endpoint: endpoint, session: session)
            result.append(request)
        }
        return result
    }

}
