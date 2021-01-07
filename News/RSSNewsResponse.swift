//
//  RSSNewsItem.swift
//  News
//
//  Created by Egor Oprea on 05.01.2021.
//

import Foundation

struct RSSNewsResponse: Decodable {
    var sourceName: String?
    var title: String?
    var pubDate: String?
    var description: String?
    var link: String?
}

extension RSSNewsResponse: Comparable {
    static func < (lhs: RSSNewsResponse, rhs: RSSNewsResponse) -> Bool {
        lhs.pubDate ?? "" < rhs.pubDate ?? ""
    }
}
