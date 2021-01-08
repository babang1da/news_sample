//
//  NewsCellModel.swift
//  News
//
//  Created by Egor Oprea on 06.01.2021.
//

import UIKit

struct NewsItem {
    var source: String?
    var title: String?
    var date: String?
    var description: String?
    var imageData: Data?
    var isFresh: Bool
    
    init(rssItem: RSSNewsResponse) {
        source = rssItem.sourceName
        title = rssItem.title
        date = rssItem.pubDate
        description = rssItem.description
        imageData = nil
        isFresh = true
    }
    
    init(dbNewsItem: DBNewsItem) {
        source = dbNewsItem.source
        title = dbNewsItem.title
        date = dbNewsItem.date
        description = dbNewsItem.newsDescription
        imageData = dbNewsItem.imageData
        isFresh = true
    }
}
