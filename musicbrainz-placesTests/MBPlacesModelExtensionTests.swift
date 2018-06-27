//
//  MBPlacesModelExtensionTests.swift
//  musicbrainz-placesTests
//
//  Created by Ramunas Jurgilas on 2018-06-27.
//  Copyright © 2018 Ramūnas Jurgilas. All rights reserved.
//

import XCTest

class MBPlacesModelExtensionTests: XCTestCase {

    func testNextOffset_40() {
        let data = "PlaceQueryRespond1".mockData()
        let places = try? JSONDecoder().decode(MBPlacesModel.self, from: data!)
        
        let offset = places?.nextOffsetFor(40)
        XCTAssert(offset == 40, "Offset must be 40.")
    }

    func testNextOffset_80() {
        let data = "PlaceQueryRespond2".mockData()
        let places = try? JSONDecoder().decode(MBPlacesModel.self, from: data!)
        
        let offset = places?.nextOffsetFor(40)
        XCTAssert(offset == 80, "Offset must be 80.")
    }

    func testNextOffset_noOffset() {
        let data = "PlaceQueryRespond3".mockData()
        let places = try? JSONDecoder().decode(MBPlacesModel.self, from: data!)
        
        let offset = places?.nextOffsetFor(40)
        XCTAssert(offset == nil, "Offset must be not nil.")
    }

}
