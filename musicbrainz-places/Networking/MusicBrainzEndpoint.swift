//
//  MusicBrainzEndpoint.swift
//  musicbrainz-places
//
//  Created by Ramunas Jurgilas on 2018-06-26.
//  Copyright © 2018 Ramūnas Jurgilas. All rights reserved.
//

import Foundation

enum MusicBrainzEndpoint {
    case place(query: String, offset: Int, limit: Int)
}

extension MusicBrainzEndpoint {
    private static let kURL = "https://musicbrainz.org/ws/2/"
    
    func url() -> URL? {
        switch self {
        case .place(let query, let offset, let limit):
            let q = "begin:[1990 TO 2018] AND \(query)"
            guard let escapedQuery = q.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else { return nil }

            let string = "\(MusicBrainzEndpoint.kURL)place/?query=\(escapedQuery)&fmt=json&offset=\(offset)&limit=\(limit)"
            print(string)
            return URL(string: string)
        }
    }
}
