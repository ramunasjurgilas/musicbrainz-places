//
//  MBPlaceAnnotationView.swift
//  musicbrainz-places
//
//  Created by Ramunas Jurgilas on 2018-06-27.
//  Copyright © 2018 Ramūnas Jurgilas. All rights reserved.
//

import UIKit
import MapKit

class MBPlaceAnnotationView: MKMarkerAnnotationView {

    var timer: Timer?

    /*
    override func prepareForDisplay() {
        super.prepareForDisplay()
        
        guard let annotation = annotation as? MBPlaceAnnotation else { return }
        
        let timeInterval = annotation.place.lifeSpanInSeconds()
        Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false) { (timer) in
            timer.invalidate()
            self.removeFromSuperview()
        }
    }
 */
}
