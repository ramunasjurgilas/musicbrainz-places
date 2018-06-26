//
//  BaseNetworking.swift
//  musicbrainz-places
//
//  Created by Ramunas Jurgilas on 2018-06-26.
//  Copyright © 2018 Ramūnas Jurgilas. All rights reserved.
//

import UIKit

enum MBNetworkError: Int {
    case corruptedUrl = -1000
    case unknownNetworkError
    case jsonDecodingError
}

extension MBNetworkError {
    static let kDomain = "com.musicbrainz.networkError"
    
    var error: NSError { get { return NSError(domain: MBNetworkError.kDomain, code: self.rawValue, userInfo: nil) } }
}

class BaseNetworking: NSObject {
    var endpoint: MusicBrainzEndpoint
    let session: URLSession
    
    init(endpoint: MusicBrainzEndpoint, session: URLSession = .shared) {
        self.endpoint = endpoint
        self.session = session
    }
    
    func execute(onSuccess: @escaping (Data) -> (), onError: @escaping (Error) -> ()) {
        guard let url = endpoint.url() else {
            onError(MBNetworkError.corruptedUrl.error)
            return
        }
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { (data, urlResponse, error) in
            if let data = data {
                onSuccess(data)
            }
            else {
                onError(error ?? MBNetworkError.unknownNetworkError.error)
            }
        }
        task.resume()
    }
    
    func execute<T>(_ type: T.Type, onSuccess: @escaping (T) -> (), onError: @escaping (Error) -> ()) where T : Decodable {
        execute(onSuccess: { (data) in
            do {
                let result = try JSONDecoder().decode(type, from: data)
                onSuccess(result)
            } catch let error {
                onError(error)
            }
        }, onError: { onError($0) })
    }
}
