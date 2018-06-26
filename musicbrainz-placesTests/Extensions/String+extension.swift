//
//  String+extension.swift
//  musicbrainz-placesTests
//
//  Created by Ramunas Jurgilas on 2018-06-26.
//  Copyright © 2018 Ramūnas Jurgilas. All rights reserved.
//

import Foundation

extension String {
    func mockData() -> Data? {
        let fileName = replacingOccurrences(of: "()", with: "")

        let testBundle = Utils.shared.testBundle()
        let fileURL = testBundle.url(forResource: fileName, withExtension: "mock")
        let result = try? Data(contentsOf: fileURL!)
        return result
    }

}
