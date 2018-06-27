//
//  MapViewControllerUISearchBarDelegateExtensionTests.swift
//  musicbrainz-placesTests
//
//  Created by Ramunas Jurgilas on 2018-06-27.
//  Copyright © 2018 Ramūnas Jurgilas. All rights reserved.
//

import XCTest
fileprivate var expect: XCTestExpectation?

class MapViewControllerUISearchBarDelegateExtensionTests: XCTestCase {
    
    var vc: MapViewController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: type(of: self)))
        vc = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        let _ =  vc.view
    }
    
}
