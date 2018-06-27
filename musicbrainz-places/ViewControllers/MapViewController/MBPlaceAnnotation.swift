//
//  MBPlaceAnnotation.swift
//  musicbrainz-places
//
//  Created by Ramunas Jurgilas on 2018-06-27.
//  Copyright © 2018 Ramūnas Jurgilas. All rights reserved.
//

import UIKit
import MapKit

class MBPlaceAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    let place: MBPlaceModel
    
    init(_ place: MBPlaceModel) {
        self.place = place
        coordinate = place.coordinate()
        title = place.name
        
        super.init()
    }
}
