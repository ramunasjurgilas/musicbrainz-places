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
            guard let escapedQuery = query.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else { return nil }
//            "%22Nice%20Studio%22%20AND%20arid:0383dadf-2a4e-4d10-a46a-e9e041da8eb3"
            let string = "\(MusicBrainzEndpoint.kURL)place/?query=\(escapedQuery)&fmt=json&offset=\(offset)&limit=\(limit)"
            print(string)
            return URL(string: string)
        }
    }
}
