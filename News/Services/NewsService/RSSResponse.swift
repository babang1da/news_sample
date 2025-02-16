//
//  RSSNewsItem.swift
//  News
//
//  Created by Egor Oprea on 05.01.2021.
//

import Foundation

struct RSSResponse: Decodable {
    var sourceName: String?
    var title: String?
    var pubDate: String?
    var description: String?
    var link: String?
    var url: String?
    
    enum CodingKeys: String, CodingKey {
        case sourceName
        case title
        case pubDate
        case description
        case link
        case url = "enclosure"
    }
}

extension RSSResponse: Comparable {
    static func < (lhs: RSSResponse, rhs: RSSResponse) -> Bool {
        lhs.pubDate ?? "" < rhs.pubDate ?? ""
    }
}
