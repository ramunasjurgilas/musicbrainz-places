//
//  MBPlaceAnnotation.swift
//  musicbrainz-places
//
//  Created by Ramunas Jurgilas on 2018-06-27.
//  Copyright © 2018 Ramūnas Jurgilas. All rights reserved.
//

import UIKit
import MapKit

protocol MBPlaceAnnotationDelegate {
    func didEndLifeSpanFor(_ annotation: MBPlaceAnnotation)
}

class MBPlaceAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    let place: MBPlaceModel
    var delegate: MBPlaceAnnotationDelegate?
    var timer: Timer?
    
    init(_ place: MBPlaceModel, delegate: MBPlaceAnnotationDelegate) {
        self.place = place
        self.delegate = delegate
        coordinate = place.coordinate()
        title = place.name
        
        super.init()
    }
    
    func startTimer() {
        let timeInterval = place.lifeSpanInSeconds()
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false) { [weak self] (timer) in
            timer.invalidate()
            if let safeSelf = self {
                safeSelf.delegate?.didEndLifeSpanFor(safeSelf)
            }
        }
    }
    
    func stopTimer() {
        delegate = nil
        timer?.invalidate()
    }
}
