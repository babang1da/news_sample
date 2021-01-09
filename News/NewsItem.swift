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
    
    init(dbNewsItem: DBNewsItem) {
        source = dbNewsItem.source
        title = dbNewsItem.title
        date = dbNewsItem.date
        description = dbNewsItem.newsDescription
        imageData = dbNewsItem.imageData
        isFresh = true
    }
}
