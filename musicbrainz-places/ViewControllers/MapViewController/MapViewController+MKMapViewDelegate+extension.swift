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
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "placeAnnotation")
        if annotationView == nil {
            annotationView = MBPlaceAnnotationView(annotation: annotation, reuseIdentifier: "placeAnnotation")
        }
        if let markerAnnotation = annotationView as? MKMarkerAnnotationView {
            markerAnnotation.clusteringIdentifier = "annotation"
        }
        return annotationView

    }
}
