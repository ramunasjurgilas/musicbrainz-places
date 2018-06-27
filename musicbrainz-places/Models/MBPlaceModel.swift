//
//  MBPlaceModel.swift
//  musicbrainz-places
//
//  Created by Ramunas Jurgilas on 2018-06-26.
//  Copyright © 2018 Ramūnas Jurgilas. All rights reserved.
//

import Foundation

struct MBPlaceModel: Codable {
    let name: String
    var coordinates: MBCoordinatesModel
    let lifeSpan: MBLifeSpanModel
    
    private enum CodingKeys : String, CodingKey {
        case name, coordinates, lifeSpan = "life-span"
    }
}
