//
//  MapViewControllerTests.swift
//  musicbrainz-placesTests
//
//  Created by Ramunas Jurgilas on 2018-06-27.
//  Copyright © 2018 Ramūnas Jurgilas. All rights reserved.
//

import XCTest

class MapViewControllerTests: XCTestCase, MBPlaceBatchRequestDelegate {
    var vc: MapViewController!
    fileprivate var expect: XCTestExpectation?
    fileprivate var expectFail: XCTestExpectation?

    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: type(of: self)))
        vc = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        let _ =  vc.view
    }
    
    func testAddPlacesOnMapOk() {
        expect = expectation(description: "Wait for place to be added.")
        let reqeust = MBPlaceBatchRequestMock()
        let session = URLSessionMock()
        reqeust.delegate = self
        session.data = "PlaceQueryRespond".mockData()
        reqeust.session = session
        vc.placeBatchRequest = reqeust
        vc.loadPlaces()
        
        waitForExpectations(timeout: 2) { (error) in
            XCTAssert(self.vc.mapView.annotations.count == 1, "Must be only one place on the map.")
        }
    }

    func testAddPlacesOnMapFail() {
        expectFail = expectation(description: "Wait for fail.")
        let reqeust = MBPlaceBatchRequest()
        let session = URLSessionMock()
        reqeust.delegate = self
        session.data = Data()
        reqeust.session = session
        vc.placeBatchRequest = reqeust
        vc.loadPlaces()
        
        waitForExpectations(timeout: 2) { (error) in
            XCTAssert(self.vc.mapView.annotations.count == 0, "Must be only one place on the map.")
        }
    }

    func didFetch(places: [MBPlaceModel]) {
        vc.didFetch(places: places)
    }
    
    func didCompleteFetching(_ error: Error?) {
        vc.didCompleteFetching(error)
        
        if error != nil {
            expectFail?.fulfill()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.expect?.fulfill()
        }
    }

}
