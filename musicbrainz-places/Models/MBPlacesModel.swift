//
//  MBPlacesModel.swift
//  musicbrainz-places
//
//  Created by Ramunas Jurgilas on 2018-06-26.
//  Copyright © 2018 Ramūnas Jurgilas. All rights reserved.
//

import Foundation

struct MBPlacesModel: Codable {
    let count: Int?
    let offset: Int
    let places: [MBPlaceModel]
}

extension MBPlacesModel {
    var maxCount: Int { get { return 100 } }
    
    func nextOffsetFor(_ limit: Int) -> Int? {
        let nextOffset = limit + offset
        if (nextOffset >= maxCount) || (nextOffset >= count ?? 0) {
            return nil
        }
        return nextOffset
    }
}
