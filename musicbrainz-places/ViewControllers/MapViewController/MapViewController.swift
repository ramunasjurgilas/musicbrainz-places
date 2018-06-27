//
//  ViewController.swift
//  musicbrainz-places
//
//  Created by Ramunas Jurgilas on 2018-06-26.
//  Copyright © 2018 Ramūnas Jurgilas. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var loadPlacesButton: UIButton!
    
    var placeBatchRequest = MBPlaceBatchRequest()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        placeBatchRequest.delegate = self
        
        loadPlaces()
    }


    // MARK: - IBAction
    
    @IBAction func didClickLoadPlaces(_ sender: UIButton) {
        mapView.annotations.forEach {
            if let annotation = $0 as? MBPlaceAnnotation {
                annotation.startTimer()
                mapView.removeAnnotation(annotation)
            }
        }
        loadPlaces()
    }
    
    func loadPlaces() {
        loadPlacesButton.isEnabled = false
        placeBatchRequest.fetchUsing(mapView.luceneSearchCoordinateQuery(), limit: 20)
    }
}
