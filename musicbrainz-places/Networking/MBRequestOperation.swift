//
//  MBRequestOperation.swift
//  musicbrainz-places
//
//  Created by Ramunas Jurgilas on 2018-06-26.
//  Copyright © 2018 Ramūnas Jurgilas. All rights reserved.
//

import UIKit

class MBRequestOperation<ResultType>: Operation where ResultType : Codable {

    let networking: BaseNetworking
    var result: ResultType?
    var error: Error?
    
    init(networking: BaseNetworking) {
        self.networking = networking
        
        super.init()
    }
    
    override func start() {
        isExecuting = true
        isFinished = false
        main()
    }
    
    override func main() {
        if isCancelled {
            isExecuting = false
            isFinished = true
            return
        }
        networking.execute(ResultType.self, onSuccess: { [weak self] (result) in
            self?.result = result
            self?.isFinished = true
        }, onError: { [weak self] (error) in
            self?.error = error
            self?.isFinished = true
        })
    }
    
    fileprivate var _executing: Bool = false
    override var isExecuting: Bool {
        get {
            return _executing
        }
        set {
            if _executing != newValue {
                willChangeValue(forKey: "isExecuting")
                _executing = newValue
                didChangeValue(forKey: "isExecuting")
            }
        }
    }
    
    fileprivate var _finished: Bool = false;
    override var isFinished: Bool {
        get {
            return _finished
        }
        set {
            if _finished != newValue {
                willChangeValue(forKey: "isFinished")
                _finished = newValue
                didChangeValue(forKey: "isFinished")
            }
        }
    }
}

