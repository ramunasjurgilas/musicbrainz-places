//
//  MBPlaceBatchRequest.swift
//  musicbrainz-places
//
//  Created by Ramunas Jurgilas on 2018-06-26.
//  Copyright © 2018 Ramūnas Jurgilas. All rights reserved.
//

import UIKit

protocol MBPlaceBatchRequestDelegate {
    func didFetch(places: [MBPlaceModel])
    func didCompleteFetching(_ error: Error?)
}

class MBPlaceBatchRequest: NSObject {
    var session: URLSession?
    var delegate: MBPlaceBatchRequestDelegate?

    func fetchUsing(_ query: String, limit: Int, offset: Int = 0) {
        let endpoint = MusicBrainzEndpoint.place(query: query, offset: offset, limit: limit)
        let request = BaseNetworking(endpoint: endpoint, session: session)
        request.execute(MBPlacesModel.self, onSuccess: { [weak self] (places) in
            self?.delegate?.didFetch(places: places.places)
            if let nextOffset = places.nextOffsetFor(limit) {
                self?.fetchUsing(query, limit: limit, offset: nextOffset)
            }
            else {
                self?.delegate?.didCompleteFetching(nil)
            }
        }, onError: { [weak self] (error) in
            self?.delegate?.didCompleteFetching(error)
        })
    }
}



