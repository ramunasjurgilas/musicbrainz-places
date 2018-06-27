//
//  MapViewController+MBPlaceBatchRequestDelegate+extension.swift
//  musicbrainz-places
//
//  Created by Ramunas Jurgilas on 2018-06-27.
//  Copyright © 2018 Ramūnas Jurgilas. All rights reserved.
//

import Foundation
import UIKit

extension MapViewController: MBPlaceBatchRequestDelegate {
    func didFetch(places: [MBPlaceModel]) {
        DispatchQueue.main.async {
            places.forEach {
                self.mapView.addAnnotation(MBPlaceAnnotation($0))
            }
        }
    }
    
    func didCompleteFetching(_ error: Error?) {
        DispatchQueue.main.async {
            self.loadPlacesButton.isEnabled = true
            
            if let error = error {
                let alert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
