//
//  MKMapView+extension.swift
//  musicbrainz-places
//
//  Created by Ramunas Jurgilas on 2018-06-27.
//  Copyright © 2018 Ramūnas Jurgilas. All rights reserved.
//

import Foundation
import MapKit

typealias Edges = (ne: CLLocationCoordinate2D, sw: CLLocationCoordinate2D)

extension MKMapView {
    func edgeCoordinates() -> Edges {
        let nePoint = CGPoint(x: self.bounds.maxX, y: self.bounds.origin.y)
        let swPoint = CGPoint(x: self.bounds.minX, y: self.bounds.maxY)
        let neCoord = self.convert(nePoint, toCoordinateFrom: self)
        let swCoord = self.convert(swPoint, toCoordinateFrom: self)
        return (ne: neCoord, sw: swCoord)
    }
    
    func luceneSearchCoordinateQuery() -> String {
        let edge = edgeCoordinates()
        let result = """
            lat:[\(edge.sw.latitude) TO \(edge.ne.latitude)] AND
            long:[\(edge.sw.longitude) TO \(edge.ne.longitude)]
        """
        return result
    }
}
