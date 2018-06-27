//
//  MusicBrainzEndpointTests.swift
//  musicbrainz-placesTests
//
//  Created by Ramunas Jurgilas on 2018-06-26.
//  Copyright © 2018 Ramūnas Jurgilas. All rights reserved.
//

import XCTest
@testable import musicbrainz_places

class MusicBrainzEndpointTests: XCTestCase {

    func testPlaceSearchUrl() {
        let query = "\"Nice Studio\" AND arid:0383dadf-2a4e-4d10-a46a-e9e041da8eb3"
        
        let url = MusicBrainzEndpoint.place(query: query, offset: 10, limit: 5).url()

        XCTAssert(url != nil, "URL is nil. Should not be nil")
        guard let safeUrl = url else { return }
        
        let components = URLComponents(url: safeUrl, resolvingAgainstBaseURL: true)
        
        let offsetItem = URLQueryItem(name: "offset", value: "10")
        let limitItem = URLQueryItem(name: "limit", value: "5")
        let queryItem = URLQueryItem(name: "query", value: "begin:[1990 TO 2018] AND " + query)
        
        XCTAssert(components?.queryItems?.contains(offsetItem) ?? false, "Offset must be added to URL")
        XCTAssert(components?.queryItems?.contains(limitItem) ?? false, "Limit must be added to URL")
        XCTAssert(components?.queryItems?.contains(queryItem) ?? false, "Query must be added to URL")
    }

}
