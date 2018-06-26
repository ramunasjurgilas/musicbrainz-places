//
//  Utils.swift
//  musicbrainz-placesTests
//
//  Created by Ramunas Jurgilas on 2018-06-26.
//  Copyright © 2018 Ramūnas Jurgilas. All rights reserved.
//

import Foundation


class Utils: NSObject {
    
    static let shared = Utils()
    
    func testBundle() -> Bundle {
        return Bundle(for: type(of: self))
    }
}
