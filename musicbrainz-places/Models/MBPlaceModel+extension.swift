//
//  MBPlaceModel+extension.swift
//  musicbrainz-places
//
//  Created by Ramunas Jurgilas on 2018-06-27.
//  Copyright © 2018 Ramūnas Jurgilas. All rights reserved.
//

import Foundation
import MapKit

extension MBPlaceModel {
    func coordinate() -> CLLocationCoordinate2D {
        guard
            let lat = CLLocationDegrees(coordinates.latitude),
            let lon = CLLocationDegrees(coordinates.longitude) else {
            return CLLocationCoordinate2D()
        }
        return CLLocationCoordinate2D(latitude: lat, longitude: lon)
    }
    
    func lifeSpanInSeconds() -> TimeInterval {
        let years = Calendar.current.component(.year, from: lifeSpan.begin)
        return TimeInterval(years - MBConfig.openPlacesFromYears)
    }
}
