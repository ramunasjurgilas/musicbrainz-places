//
//  MapViewController+UISearchBarDelegate+extension.swift
//  musicbrainz-places
//
//  Created by Ramunas Jurgilas on 2018-06-27.
//  Copyright © 2018 Ramūnas Jurgilas. All rights reserved.
//

import UIKit

extension MapViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let query = searchBar.text, query.count > 0 {
            placeBatchRequest.query = query
            placeBatchRequest.fetch()
            return
        }
        
        let alert = UIAlertController(title: nil, message: "Please enter query", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

}
