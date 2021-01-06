//
//  RSSNewsItem.swift
//  News
//
//  Created by Egor Oprea on 05.01.2021.
//

import Foundation

struct RSSNewsItem: Decodable {
    var sourceName: String?
    var title: String?
    var pubDate: String?
    var description: String?
    var link: String?
}

extension RSSNewsItem: Comparable {
    static func < (lhs: RSSNewsItem, rhs: RSSNewsItem) -> Bool {
        lhs.pubDate ?? "" < rhs.pubDate ?? ""
    }
}
