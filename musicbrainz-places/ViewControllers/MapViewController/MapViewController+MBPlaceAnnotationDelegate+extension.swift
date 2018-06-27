//
//  MapViewController+MBPlaceAnnotationDelegate+extension.swift
//  musicbrainz-places
//
//  Created by Ramunas Jurgilas on 2018-06-27.
//  Copyright © 2018 Ramūnas Jurgilas. All rights reserved.
//

import Foundation

extension MapViewController: MBPlaceAnnotationDelegate {
    func didEndLifeSpanFor(_ annotation: MBPlaceAnnotation) {
        let filtered = mapView.annotations.filter { ($0 as? MBPlaceAnnotation) == annotation }
        mapView.removeAnnotations(filtered)
    }
}
