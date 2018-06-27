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
    let queue = OperationQueue()
    var session: URLSession?
    var delegate: MBPlaceBatchRequestDelegate?
    
    var query: String? {
        didSet {
            requests = baseNetworking()
        }
    }
    lazy var requests: [BaseNetworking] = baseNetworking()
    
    deinit {
        queue.removeObserver(self, forKeyPath: "operations")
    }
    
    override init() {
        super.init()
        
        queue.maxConcurrentOperationCount = 1;
        queue.addObserver(self, forKeyPath: "operations", options: NSKeyValueObservingOptions(rawValue: 0), context: nil)
    }

    func fetchUsing(_ query: String, limit: Int, offset: Int = 0) {
        let endpoint = MusicBrainzEndpoint.place(query: query, offset: offset, limit: limit)
        let request = BaseNetworking(endpoint: endpoint, session: session)
        request.execute(MBPlacesModel.self, onSuccess: { [weak self] (places) in
            self?.delegate?.didFetch(places: places.places)
            print("--->> Count: \(places.count)")
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
    
    func fetch() {
        queue.cancelAllOperations()
        
        var operations: [Operation] = []
        
        requests.forEach {
            let operation = MBRequestOperation<MBPlacesModel>(networking: $0)
            operations.append(operation)
            operation.completionBlock = { [weak self, unowned operation] in
                if let places = operation.result?.places {
                    self?.delegate?.didFetch(places: places)
                }
            }
        }
        queue.addOperations(operations, waitUntilFinished: false)
    }
    
    private func baseNetworking() -> [BaseNetworking] {
        let limit = 20
        var result: [BaseNetworking] = []
        for offset in stride(from: 0, to: 100, by: limit) {
            print("Offset: \(offset) limit: \(limit)")
            let endpoint = MusicBrainzEndpoint.place(query: query ?? "", offset: offset, limit: limit)
            result.append(BaseNetworking(endpoint: endpoint))
        }
        return result
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "operations" {
            if queue.operations.count == 0 {
                delegate?.didCompleteFetching(nil)
            }
        }
        else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    
    
}



