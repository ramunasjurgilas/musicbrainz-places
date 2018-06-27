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
    @IBOutlet weak var searchBar: UISearchBar!
    
    var placeBatchRequest = MBPlaceBatchRequest()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        placeBatchRequest.delegate = self
    }



}