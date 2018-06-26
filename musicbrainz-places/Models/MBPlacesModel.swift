//
//  MBPlacesModel.swift
//  musicbrainz-places
//
//  Created by Ramunas Jurgilas on 2018-06-26.
//  Copyright © 2018 Ramūnas Jurgilas. All rights reserved.
//

import Foundation

struct MBPlacesModel: Codable {
    let count: Int
    let offset: Int
    let places: [MBPlaceModel]
}
