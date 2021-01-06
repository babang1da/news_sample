//
//  NewsCellModel.swift
//  News
//
//  Created by Egor Oprea on 06.01.2021.
//

import UIKit

struct NewsCellModel {
    var source: String?
    var title: String?
    var date: String?
    var description: String?
    var image: UIImage?
    
    init(rssItem: RSSNewsItem) {
        source = rssItem.sourceName
        title = rssItem.title
        date = rssItem.pubDate
        description = rssItem.description
        image = nil
    }
}
