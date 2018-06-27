//
//  MapViewControllerUISearchBarDelegateExtensionTests.swift
//  musicbrainz-placesTests
//
//  Created by Ramunas Jurgilas on 2018-06-27.
//  Copyright © 2018 Ramūnas Jurgilas. All rights reserved.
//

import XCTest
fileprivate var expect: XCTestExpectation?

class MBPlaceBatchRequestMock: MBPlaceBatchRequest {
    override func fetch() {
        expect?.fulfill()
    }
}

class MapViewControllerUISearchBarDelegateExtensionTests: XCTestCase {
    
    var vc: MapViewController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: type(of: self)))
        vc = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        let _ =  vc.view
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSearchBarSearchButtonClickedWithText() {
        expect = expectation(description: "Expect to call fetch")
        vc.placeBatchRequest = MBPlaceBatchRequestMock()
        vc.searchBar.text = "Good"
        vc.searchBarSearchButtonClicked(vc.searchBar)
        
        waitForExpectations(timeout: 0.2) { (error) in
            if let error = error {
                XCTFail("Fetch method should be executed! \(error)")
            }
        }
    }

}
