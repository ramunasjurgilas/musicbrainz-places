//
//  MapViewController+MKMapViewDelegate+extension.swift
//  musicbrainz-places
//
//  Created by Ramunas Jurgilas on 2018-06-27.
//  Copyright © 2018 Ramūnas Jurgilas. All rights reserved.
//

import Foundation
import MapKit

extension MapViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        (annotation as? MBPlaceAnnotation)?.startTimer()
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "placeAnnotation")
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "placeAnnotation")
        }
        
        return annotationView
    }
}
